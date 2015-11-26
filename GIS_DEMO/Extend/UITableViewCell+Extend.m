//
//  UITableViewCell+Extend.m
//  Wish
//
//  Created by Lost on 15/7/28.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "UITableViewCell+Extend.h"

@implementation UITableViewCell (Extend)

-(void)setInsetHeight:(CGFloat)height color:(UIColor*)color
{
    UIImageView* bgView = [UIImageView new];
    [bgView setFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height-height)];
    [bgView setBackgroundColor:color];
    
    [self addSubview:bgView];
}

@end
