//
//  PersonalInfoAvatarCell.h
//  Wish
//
//  Created by Lost on 15/10/16.
//  Copyright © 2015年 lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PersonalInfoAvatarCell : UITableViewCell
{
    UIImageView* _bgView;
    UIImageView* _bgView1;
    UIImageView* _avatarView;
    UILabel* _nameLabel;
    UILabel* _phoneLabel;
}

- (void)setData;

@end
