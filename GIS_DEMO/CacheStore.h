//
//  CacheStore.h
//  Wish
//
//  Created by Lost on 15/9/6.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>

enum
{
    PropertyList = 0,
    Archiver = 1
};

typedef NSInteger CacheStoreType;

@interface CacheStore : NSObject {
    
@private
    NSOperationQueue* diskOperationQueue;
    NSString* _cacheDirectory;
    NSMutableDictionary* _cacheIntervalTime;
}

+ (CacheStore*)instanceCacheStore;

- (void)writeData:(NSObject*)data forKey:(NSString*)key  forType:(CacheStoreType) type timeOut:(NSTimeInterval) seconds;

- (NSObject*)dataForKey:(NSString *)key forType:(CacheStoreType)type; //如果需要长期持有，需要retain

- (BOOL)checkTimeOutForKey:(NSString*)key;
- (BOOL)deleteCacheForKey:(NSString*)key;
- (NSString*)keyForString: (NSString*) str;
- (void)removeAllCache;


- (NSString*) cachePathForKey:(NSString*)key;
- (void)performDiskWriteOperation:(NSInvocation *)invoction;

@end
