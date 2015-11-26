//
//  UINavigationBar+Extend.m
//  Wish
//
//  Created by Lost on 15/9/7.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "UINavigationBar+Extend.h"

@implementation UINavigationBar (Extend)

/**
 * Hide 1px hairline of the nav bar
 */
- (void)hideBottomHairline {
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];
    navBarHairlineImageView.hidden = YES;
}

/**
 * Show 1px hairline of the nav bar
 */
- (void)showBottomHairline {
    // Show 1px hairline of translucent nav bar
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];
    navBarHairlineImageView.hidden = NO;
}

- (void)changeBottomHairLineColor:(UIColor*)color
{
    UIImageView *navBarHairlineImageView = [self findHairlineImageViewUnder:self];
    navBarHairlineImageView.backgroundColor = [UIColor greenColor];
    navBarHairlineImageView.tintColor = [UIColor orangeColor];
}

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view {
    if ([view isKindOfClass:UIImageView.class] && view.bounds.size.height <= 1.0) {
        return (UIImageView *)view;
    }
    for (UIView *subview in view.subviews) {
        UIImageView *imageView = [self findHairlineImageViewUnder:subview];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}

- (void)makeTransparent {
    [self setTranslucent:YES];
    
    [self setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.backgroundColor = [UIColor clearColor];
    self.shadowImage = [UIImage new];    // Hides the hairline
    [self hideBottomHairline];
}

- (void)setBottomBorderColor:(UIColor *)color height:(CGFloat)height{
    CGRect bottomBorderRect = CGRectMake(0, CGRectGetHeight(self.frame), CGRectGetWidth(self.frame), height);
    UIView *bottomBorder = [[UIView alloc] initWithFrame:bottomBorderRect];
    [bottomBorder setBackgroundColor:color];
    [self addSubview:bottomBorder];
}

@end
