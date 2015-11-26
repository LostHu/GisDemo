//
//  ChangeCityViewController.h
//  Wish
//
//  Created by Lost on 15/8/24.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapData.h"

@protocol changeSelectDelegate <NSObject>
@optional
- (void)changeSelect:(MapData*)map;
@end

@interface MapDataViewController : UIViewController
{
@protected
    NSDictionary* _dicMapData;
    NSArray* _sectionTitle;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) NSArray* arrayData;
@property (nonatomic, copy) NSString* currentSelected;

@property (nonatomic, assign) id<changeSelectDelegate> delegate;

@end
