//
//  CacheStore.m
//  Wish
//
//  Created by Lost on 15/9/6.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "CacheStore.h"


#define CACHE_DIRECTORY_NAME @"Cache"
#define CACHE_TIME_OUT  60 * 10
#define CACHE_TIMEOUT_PLIST @"CacheTimeOut.plist"

static CacheStore* _cacheStore;

@implementation CacheStore

+(CacheStore*) instanceCacheStore
{
    @synchronized(self)
    {
        if(!_cacheStore)
        {
            _cacheStore = [[CacheStore alloc] init];
        }
    }
    return _cacheStore;
}

- (id)init
{
    if((self = [super init]))
    {
        diskOperationQueue = [[NSOperationQueue alloc] init];
        
        NSString* cachesDirectory = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        _cacheDirectory = [[[cachesDirectory stringByAppendingPathComponent:[[NSProcessInfo processInfo] processName]] stringByAppendingPathComponent:CACHE_DIRECTORY_NAME] copy];
        
        [[NSFileManager defaultManager] createDirectoryAtPath:_cacheDirectory withIntermediateDirectories:YES attributes:nil error:NULL];
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:[self cachePathForKey: CACHE_TIMEOUT_PLIST]])
            _cacheIntervalTime = [[NSMutableDictionary alloc] initWithContentsOfFile: [self cachePathForKey: CACHE_TIMEOUT_PLIST]];
        
        else
            _cacheIntervalTime = [[NSMutableDictionary alloc] init];
    }
    return self;
}

-(void)dealloc
{
}

-(NSString*) cachePathForKey:(NSString *)key
{
    NSString* path = [_cacheDirectory stringByAppendingPathComponent:key];
    return path;
}

-(NSString*)cachePathForString:(NSString*)str
{
    NSString* path = [_cacheDirectory stringByAppendingPathComponent:[self keyForString: str]];
    return path;
}

-(NSString*) keyForString: (NSString*) str
{
    return [NSString stringWithFormat:@"GisCache_%lu.data", (unsigned long)[str hash]];
}

-(BOOL)checkTimeOutForKey:(NSString *)key
{
    NSDate* time = [_cacheIntervalTime objectForKey:key];
    if(!time)
        return NO;
    if([(NSDate *)[NSDate date] compare:time] == NSOrderedDescending)
        return YES;
    return NO;
}

-(BOOL)deleteCacheForKey:(NSString *)key
{
    NSString* cachePath = [self cachePathForString:key];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:cachePath])
        [[NSFileManager defaultManager] removeItemAtPath:cachePath error:nil];
    
    [_cacheIntervalTime removeObjectForKey:key];
    
    [self performSelectorOnMainThread:@selector(saveAfterDelay) withObject:nil waitUntilDone:YES];
    return YES;
}

-(void)removeAllCache
{
    if([_cacheIntervalTime count] != 0)
    {
        NSArray* array = [_cacheIntervalTime allKeys];
        for(NSString* k in array)
        {
            NSString* cachePath = [self cachePathForString:k];
            if([[NSFileManager defaultManager] fileExistsAtPath:cachePath])
                [[NSFileManager defaultManager] removeItemAtPath:cachePath error:nil];
        }
        [_cacheIntervalTime removeAllObjects];
        [[NSFileManager defaultManager] removeItemAtPath:[self cachePathForKey: CACHE_TIMEOUT_PLIST] error:nil];
    }
}

-(void)writeData:(NSObject*)data forKey:(NSString*)key  forType:(CacheStoreType) type timeOut:(NSTimeInterval) seconds
{
    NSObject* aCopy = data;
    if( [data isKindOfClass:[NSArray class]] )
        aCopy = [data mutableCopy];
    
    NSString* cachePath = [self cachePathForString:key];
    NSInvocation* writeInvocation = [NSInvocation invocationWithMethodSignature:[self methodSignatureForSelector:@selector(writeData:toPath:forKey:forType:)]];
    [writeInvocation setTarget:self];
    [writeInvocation setSelector:@selector(writeData:toPath:forKey:forType:)];
    [writeInvocation setArgument:&aCopy atIndex:2];
    [writeInvocation setArgument:&cachePath atIndex:3];
    [writeInvocation setArgument:&key  atIndex:4];
    [writeInvocation setArgument:&type atIndex:5];
    
    [self performDiskWriteOperation:writeInvocation];
    
    if(seconds <= 0.0)
        seconds = CACHE_TIME_OUT;
    [_cacheIntervalTime setObject:[NSDate dateWithTimeIntervalSinceNow:seconds] forKey:key];
    
    [self performSelectorOnMainThread:@selector(saveAfterDelay) withObject:nil waitUntilDone:YES]; //确保在主线程中运行
}

- (void)saveAfterDelay
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(saveCacheDictionary) object:nil];
    [self performSelector:@selector(saveCacheDictionary) withObject:nil afterDelay:0.3];
}

- (void)saveCacheDictionary
{
    @synchronized(self)
    {
        BOOL bRet = [_cacheIntervalTime writeToFile:[self cachePathForKey: CACHE_TIMEOUT_PLIST] atomically:YES];
        if(!bRet)
            NSLog(@"Write %@ Failed",CACHE_TIMEOUT_PLIST);
    }
}

- (void)performDiskWriteOperation:(NSInvocation *)invoction {
    NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithInvocation:invoction];
    [diskOperationQueue addOperation:operation];
}


- (void)writeData:(NSObject*)data toPath:(NSString *)path forKey:(NSString*)key forType:(CacheStoreType)type
{
    BOOL bRet = NO;
    if(type == PropertyList)
    {
        if( [data isKindOfClass:[NSArray class]] )
        {
            NSArray* a = (NSArray*) data;
            bRet = [a writeToFile:path atomically:YES];
            
        }
        else if ( [data isKindOfClass:[NSDictionary class]])
        {
            NSDictionary* d = (NSDictionary*) data;
            bRet = [d writeToFile:path atomically:YES];
        }
        else if ( [data isKindOfClass:[NSData class]])
        {
            NSData* d = (NSData*)data;
            bRet = [d writeToFile:path atomically:YES];
        }
        else if ([data isKindOfClass:[NSString class]])
        {
            NSString* str = (NSString*)data;
            bRet = [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
        }
        /*
         else if ([data respondsToSelector:@selector(writeToFile:atomically:)])
         {
         bRet = [data writeToFile:path atomically:YES];
         }
         */
        else return;
    }
    else if(type == Archiver)
    {
        if( [data isKindOfClass:[NSArray class]] || [data isKindOfClass:[NSDictionary class]] )
        {
            NSData * encodedData = [NSKeyedArchiver archivedDataWithRootObject:data];
            bRet = [encodedData writeToFile:path atomically:YES];
        }
        else
        {
            NSMutableData* md = [[NSMutableData alloc] init];
            NSKeyedArchiver* archiver = [[NSKeyedArchiver alloc ]initForWritingWithMutableData:md];
            [archiver encodeObject:data forKey:key];
            [archiver finishEncoding];
            bRet = [md writeToFile:path atomically:YES];
        }
    }
    else
        return;
    
    if( [data isKindOfClass:[NSArray class]] )
        data = nil;
    
    if(bRet)
    {
        NSLog(@"Write Cache OK!");
    }
    else
    {
        NSLog(@"Write Cache Fail!");
    }
    return;
}

-(NSObject*)dataForKey:(NSString *)key forType:(CacheStoreType)type
{
    NSString* cachePath = [self cachePathForString:key];
    if(![[NSFileManager defaultManager] fileExistsAtPath:cachePath])
    {
        return nil;
    }
    
    if(type == PropertyList)
    {
        NSMutableArray* ma = [NSMutableArray arrayWithContentsOfFile:cachePath];
        if (ma != nil)
            return ma;
        
        NSMutableDictionary* md = [NSMutableDictionary dictionaryWithContentsOfFile:cachePath];
        if (md != nil)
            return  md;
        
        NSStringEncoding enc = NSUTF8StringEncoding;
        NSString* s = [NSString stringWithContentsOfFile:cachePath
                                            usedEncoding:&enc
                                                   error:nil];
        if (s != nil)
            return  s;
        
        NSData* data = [NSData  dataWithContentsOfFile: cachePath];
        if(data != nil)
            return data;
        return nil;
    }
    else if(type == Archiver)
    {
        NSData* data = [NSData  dataWithContentsOfFile: cachePath];
        if(!data)
            return nil;
        
        id oid = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if(oid != nil)
        {
            if( [oid isKindOfClass:[NSArray class]] || [oid isKindOfClass:[NSDictionary class]])
                return oid;
        }
        
        NSKeyedUnarchiver* unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        NSObject* object = [unarchiver decodeObjectForKey:key];
        [unarchiver finishDecoding];
        return object;    
    }
    return nil;
}
@end
