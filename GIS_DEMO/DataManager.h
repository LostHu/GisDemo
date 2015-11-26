//
//  DataManager.h
//  Gis
//
//  Created by lost on 15/10/24.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MapData.h"

@interface DataManager : NSObject
{
    // 热门数据
    NSMutableArray* _topDatas;
    
    // 原始数据
    NSMutableArray* _datas;
    // 为了table方便使用的字典,通过原始数据+热门数据结合未来
    NSMutableDictionary* _dicDatas;
    
    // 标题数组
    NSMutableArray* _sectionData;
}

- (NSDictionary*)getDicData;

- (void)setTopData:(MapData*)data;

- (NSArray*)getSectionTitle;

- (NSArray*)getDLSectionTitle;

- (NSDictionary*)getDLDicData;

@end
