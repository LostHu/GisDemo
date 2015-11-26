//
//  DataManager.m
//  Gis
//
//  Created by lost on 15/10/24.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "DataManager.h"
#import "MapData.h"
#import "FMDB.h"
#import "FMDatabase.h"
#import "CacheStore.h"

@implementation DataManager

- (id)init
{
    if ( (self = [super init]) ) {
        [self initTopData];
        [self insertData];
        [self initOriData];
    }
    
    return self;
}

- (NSString *)databaseFilePath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    NSLog(@"%@",filePath);
    NSString *dbFilePath = [documentPath stringByAppendingPathComponent:@"db.sqlite"];
    return dbFilePath;
}

- (NSString *)tableName
{
    return @"gisdata";
}

- (void)setTopData:(MapData *)data
{
    if (_topDatas == nil) {
        _topDatas = [[NSMutableArray alloc] init];
    }
    
    for (MapData* oldMap in _topDatas) {
        if ([oldMap.name isEqualToString:data.name]) {
            [_topDatas removeObject:oldMap];
            break;
        }
    }
    [_topDatas insertObject:data atIndex:0];
    
    // 热门数据最多10个
    if (_topDatas.count > 10) {
        [_topDatas removeLastObject];
    }
    
    [[CacheStore instanceCacheStore] writeData:_topDatas forKey:@"TopData" forType:Archiver timeOut:0];
}

- (void)initTopData
{
    NSMutableArray* array = (NSMutableArray*)[[CacheStore instanceCacheStore] dataForKey:@"TopData" forType:Archiver];
    if (array && [array isKindOfClass:[NSMutableArray class]]) {
        _topDatas = array;
    }
}

- (void)makeShowData
{
    if (_sectionData == nil) {
        _sectionData = [[NSMutableArray alloc] init];
    }
    
    if (_dicDatas == nil) {
        _dicDatas = [[NSMutableDictionary alloc] init];
    }
    
    if (_topDatas && _topDatas.count > 0) {
        for (MapData* map in _topDatas) {
            
            NSString* key = @"热门";
            if (![_dicDatas objectForKey:key]) {
                NSMutableArray* arrayM = [[NSMutableArray alloc] initWithObjects:map, nil];
                [_dicDatas setObject:arrayM forKey:key];
                
                [_sectionData addObject:key];
            }
            else
            {
                [[_dicDatas objectForKey:key] addObject:map];
            }
        }
    }
    
    if (_datas && _datas.count > 0) {
        for (MapData* map in _datas) {
            
            NSString* key = map.managementUnit;
            if (![_dicDatas objectForKey:key]) {
                NSMutableArray* arrayM = [[NSMutableArray alloc] initWithObjects:map, nil];
                [_dicDatas setObject:arrayM forKey:key];
                
                [_sectionData addObject:key];
            }
            else
            {
                [[_dicDatas objectForKey:key] addObject:map];
            }
        }
    }
}

- (void)makeDLData
{
    if (_sectionData == nil) {
        _sectionData = [[NSMutableArray alloc] init];
    }
    [_sectionData removeAllObjects];
    
    if (_dicDatas == nil) {
        _dicDatas = [[NSMutableDictionary alloc] init];
    }
    [_dicDatas removeAllObjects];
    
    if (_datas && _datas.count > 0) {
        for (MapData* map in _datas) {
            
            NSString* key = map.managementUnit;
            if (![_dicDatas objectForKey:key]) {
                NSMutableArray* arrayM = [[NSMutableArray alloc] initWithObjects:map, nil];
                [_dicDatas setObject:arrayM forKey:key];
                
                [_sectionData addObject:key];
            }
            else
            {
                [[_dicDatas objectForKey:key] addObject:map];
            }
        }
    }
}

- (void)insertData
{
    FMDatabase *db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    
    if (db == nil) {
        
    }
    
    if (![db open]) {
        return;
    }
    
    if (![db tableExists:[self tableName]]) {
        NSString* SQL = [NSString stringWithFormat:@"CREATE TABLE %@(name TEXT PRIMARY KEY, managementUnit TEXT, drawingType TEXT, drawingDir TEXT)",[self tableName]];
        BOOL res = [db executeUpdate:SQL];
        if (!res) {
            NSLog(@"error to CREATE data");
        }else{
            NSLog(@"CREATE succeed");
        }
        
        NSArray* arrayUnity = [NSArray arrayWithObjects:@"东昌",@"东明",@"高桥",@"花木",@"金桥",@"北蔡",@"联洋",@"张江",
                               @"康桥",@"潍坊",@"唐镇",nil];
        
        for (int i=0 ; i<arrayUnity.count; i++) {
            for (int j=1; j<=10; j++) {
                NSString* sql = [NSString stringWithFormat:@"INSERT INTO %@ (name,managementUnit,drawingType,drawingDir) VALUES (?,?,?,?)",[self tableName]];
                
                NSString* name = [NSString stringWithFormat:@"%d",i*10+j];
                NSString* managementUnit = [arrayUnity objectAtIndex:i];
                NSString* drawingType = j>5 ? @"单线图" : @"地理接线图";
                NSString* drawingDir = [NSString stringWithFormat:@"b%d",j%5];
                if (j%5==0) {
                    drawingDir = @"b5";
                }
                
                BOOL res = [db executeUpdate:sql,name,managementUnit,drawingType,drawingDir];
                if (!res) {
                    NSLog(@"error to insert data");
                }else{
                    NSLog(@"insert succeed");
                }
            }
        }
    }
    
    [db close];
}

- (void)initOriData
{
    // 初始化热门数据
    NSMutableArray* array = (NSMutableArray*)[[CacheStore instanceCacheStore] dataForKey:@"TopData" forType:Archiver];
    if (array && [array isKindOfClass:[NSMutableArray class]]) {
        _topDatas = array;
    }
    
    // 初始化数据库数据
    FMDatabase *db = [FMDatabase databaseWithPath:[self databaseFilePath]];
    
    if (![db open]) {
        return;
    }
    
    
    if (_datas == nil) {
        _datas = [[NSMutableArray alloc] init];
    }
    
    // some operation
    FMResultSet *s = [db executeQuery:@"SELECT * FROM GisData"];
    while ([s next]) {
        
        MapData* map = [[MapData alloc] init];
        map.name = [s stringForColumn:@"name"];
        map.managementUnit = [s stringForColumn:@"managementUnit"];
        map.drawingType = [s stringForColumn:@"drawingType"];
        map.drawingDir = [s stringForColumn:@"drawingDir"];
        
        [_datas addObject:map];
    }
    
    [db close];
}

//- (void)initData
//{
//    if (_datas == nil) {
//        _datas = [[NSMutableArray alloc] init];
//    }
//    
//    if (_dicDatas == nil) {
//        _dicDatas = [[NSMutableDictionary alloc] init];
//    }
//    
//    NSArray* array = [NSArray arrayWithObjects:@"东昌",@"东明",@"高桥",@"花木",@"金桥",@"北蔡",@"联洋",@"张江",
//                      @"康桥",@"潍坊",@"唐镇",nil];
//    
//    for (int i=0 ; i<array.count; i++) {
//        MapData* map = [[MapData alloc] init];
//        map.name = [NSString stringWithFormat:@"%d",i];
//        map.managementUnit = [array objectAtIndex:i];
//        map.drawingType = @"单线图";
//        map.drawingDir = @"b1";
//        
//        [_datas addObject:map];
//        
//        map = [[MapData alloc] init];
//        map.name = [NSString stringWithFormat:@"%d",i];
//        map.managementUnit = [array objectAtIndex:i];
//        map.drawingType = @"地理接线图";
//        map.drawingDir = @"b2";
//        
//        [_datas addObject:map];
//    }
//    
//    
//    for (MapData* map in _datas) {
//        
//        NSString* key = map.managementUnit;
//        if (![_dicDatas objectForKey:key]) {
//            NSMutableArray* arrayM = [[NSMutableArray alloc] initWithObjects:map, nil];
//            [_dicDatas setObject:arrayM forKey:key];
//        }
//        else
//        {
//            [[_dicDatas objectForKey:key] addObject:map];
//        }
//    }
//}

- (NSArray*)getSectionTitle
{
    return [NSArray arrayWithArray:_sectionData];
}

- (NSDictionary*)getDicData
{
    [self makeShowData];
    return [NSDictionary dictionaryWithDictionary:_dicDatas];
}

- (NSArray*)getDLSectionTitle
{
//    [self makeDLData];
    return [NSArray arrayWithArray:_sectionData];
}

- (NSDictionary*)getDLDicData
{
    [self makeDLData];
    return [NSDictionary dictionaryWithDictionary:_dicDatas];
}

@end
