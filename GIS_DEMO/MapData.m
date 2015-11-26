//
//  MapData.m
//  Gis
//
//  Created by lost on 15/10/23.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "MapData.h"

@implementation MapData

//===========================================================
//  Keyed Archiving
//
//===========================================================
- (void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.managementUnit forKey:@"managementUnit"];
    [encoder encodeObject:self.drawingType forKey:@"drawingType"];
    [encoder encodeObject:self.drawingDir forKey:@"drawingDir"];
}

- (id)initWithCoder:(NSCoder *)decoder
{
    self = [super init];
    if (self) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.managementUnit = [decoder decodeObjectForKey:@"managementUnit"];
        self.drawingType = [decoder decodeObjectForKey:@"drawingType"];
        self.drawingDir = [decoder decodeObjectForKey:@"drawingDir"];
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    id theCopy = [[[self class] allocWithZone:zone] init];  // use designated initializer
    
    [theCopy setName:[self.name copy]];
    [theCopy setManagementUnit:[self.managementUnit copy]];
    [theCopy setDrawingType:[self.drawingType copy]];
    [theCopy setDrawingDir:[self.drawingDir copy]];
    
    return theCopy;
}

@end
