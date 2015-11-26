//
//  WebBottomView.m
//  GIS_DEMO
//
//  Created by lost on 15/10/27.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "WebBottomView.h"

@interface WebBottomView()
{
    UIImageView* _line;
    UILabel* _nameLabel;
}
@end

@implementation WebBottomView

- (void)setData:(NSString*)data
{
    [self setBackgroundColor:[UIColor whiteColor]];
    
    if(_line == nil)
    {
        _line = [[UIImageView alloc] init];
        [self addSubview:_line];
    }
    
    [_line setBackgroundColor:[UIColor orangeColor]];
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(self.mas_top).offset(1);
        make.width.equalTo(self);
    }];
    
    if(_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
    }
    
    {
        [_nameLabel setTextAlignment:NSTextAlignmentLeft];
        [_nameLabel setText:data];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.left.equalTo(self.mas_left).offset(10);
            make.right.equalTo(self.mas_right).offset(-10);
        }];
    }
}

@end
