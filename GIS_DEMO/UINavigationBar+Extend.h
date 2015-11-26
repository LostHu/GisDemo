//
//  UINavigationBar+Extend.h
//  Wish
//
//  Created by Lost on 15/9/7.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (Extend)
- (void)hideBottomHairline;
- (void)showBottomHairline;
- (void)makeTransparent;
- (void)changeBottomHairLineColor:(UIColor*)color;
- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;
- (void)setBottomBorderColor:(UIColor *)color height:(CGFloat)height;
@end
