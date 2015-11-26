//
//  UILabel+Extend.m
//  Wish
//
//  Created by lost on 15/7/17.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "UILabel+Extend.h"
//#import "RTLabel.h"
#import "UIAttributeItem.h"

@implementation UILabel (Extend)

- (CGSize)boundingRectWithSize:(CGSize)size
{
    NSDictionary *attribute = @{NSFontAttributeName: self.font};
    
    CGSize retSize = [self.text boundingRectWithSize:size
                                             options:\
                      NSStringDrawingTruncatesLastVisibleLine |
                      NSStringDrawingUsesLineFragmentOrigin |
                      NSStringDrawingUsesFontLeading
                                          attributes:attribute
                                             context:nil].size;
    
    return retSize;
}

//+ (CGSize)calcContent:(NSString*)str Size:(CGFloat)width textStyle:(UIAttributeItem*)item
//{
//    NSLog(@"calcContent:%@",str);
//    
//    RTLabel* label = [[RTLabel alloc] initWithFrame:CGRectMake(0, 0, width, CGFLOAT_MAX)];
//    
//    [label setFont:item.font];
//    [label setTextColor:item.color];
//    [label setText:str];
//    CGSize optimumSize = [label optimumSize];
//    label = nil;
//    
//    return optimumSize;
//}

@end
