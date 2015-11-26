//
//  UILabel+Extend.h
//  Wish
//
//  Created by lost on 15/7/17.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "UIAttributeItem.h"

@class UIAttributeItem;
@interface UILabel (Extend)

- (CGSize)boundingRectWithSize:(CGSize)size;

//+ (CGSize)calcContent:(NSString*)str Size:(CGFloat)width textStyle:(UIAttributeItem*)item;

@end
