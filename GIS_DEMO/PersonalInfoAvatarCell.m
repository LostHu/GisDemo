//
//  PersonalInfoAvatarCell.m
//  Wish
//
//  Created by Lost on 15/10/16.
//  Copyright © 2015年 lost. All rights reserved.
//

#import "PersonalInfoAvatarCell.h"
#import "PublicHeader.h"

@implementation PersonalInfoAvatarCell

- (void)setData
{
    if(_bgView == nil)
    {
        _bgView = [[UIImageView alloc] init];
        [self addSubview:_bgView];
    }
    
    [_bgView setBackgroundColor:COLOR4RGB(205,205,205)];
    [_bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(50, 50));
        _bgView.layer.masksToBounds = YES;
        _bgView.layer.cornerRadius = 25;
    }];
    
    if(_bgView1 == nil)
    {
        _bgView1 = [[UIImageView alloc] init];
        [self addSubview:_bgView1];
    }
    
    {
        [_bgView1 setBackgroundColor:[UIColor orangeColor]];
        [_bgView1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(_bgView);
            UIEdgeInsets padding = UIEdgeInsetsMake(5, 5, 5, 5);
            make.edges.equalTo(_bgView).with.insets(padding);
            _bgView1.layer.masksToBounds = YES;
            _bgView1.layer.cornerRadius = 20;
        }];
    }
    
    UIImage* anImage = [UIImage imageNamed:ImageFilePath(@"nav_user.png")];
    anImage = [anImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    if(_avatarView == nil)
    {
        _avatarView = [[UIImageView alloc] initWithImage:anImage];
        [self addSubview:_avatarView];
    }
    
    _avatarView.tintColor = [UIColor whiteColor];
    [_avatarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(_bgView1);
        make.size.mas_equalTo(anImage.size);
    }];
    
    if(_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] init];
        [self addSubview:_nameLabel];
    }
    
    {
        [_nameLabel setTextAlignment:NSTextAlignmentLeft];
        [_nameLabel setText:@"萧峰"];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(_bgView.mas_centerY).offset(-2);
            make.left.equalTo(_bgView.mas_right).offset(15);
            make.right.equalTo(self.mas_right).offset(-50);
            make.height.equalTo(@(16));
        }];
    }
    
    if(_phoneLabel == nil)
    {
        _phoneLabel = [[UILabel alloc] init];
        [self addSubview:_phoneLabel];
    }
    
    {
        [_phoneLabel setTextAlignment:NSTextAlignmentLeft];
        [_phoneLabel setText:@"12345678901"];
        [_phoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_bgView.mas_centerY).offset(2);
            make.left.equalTo(_bgView.mas_right).offset(15);
            make.right.equalTo(self.mas_right).offset(-50);
            make.height.equalTo(@(16));
        }];
    }
}

@end
