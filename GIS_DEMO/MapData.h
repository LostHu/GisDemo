//
//  MapData.h
//  Gis
//
//  Created by lost on 15/10/23.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MapData : NSObject<NSCoding,NSCopying>

// 名称
@property (nonatomic,copy) NSString* name;
// 所属单位
@property (nonatomic,copy) NSString* managementUnit;
// 图纸类型
@property (nonatomic,copy) NSString* drawingType;
// 图纸路径
@property (nonatomic,copy) NSString* drawingDir;

@end
