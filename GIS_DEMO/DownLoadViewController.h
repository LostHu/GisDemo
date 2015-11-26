//
//  DownLoadViewController.h
//  GIS_DEMO
//
//  Created by lost on 15/11/24.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DownLoadViewController : UIViewController
{
@protected
    NSDictionary* _dicMapData;
    NSArray* _sectionTitle;
}

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, retain) NSArray* arrayData;
@property (nonatomic, copy) NSString* currentSelected;

@end
