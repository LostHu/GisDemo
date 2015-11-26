//
//  TextAttributeItem.h
//  Wish
//
//  Created by lost on 15/7/14.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#define TagURLTemplate @"<a href='%@'>%@</a>"
#define WishTagRegular @"(#([a-zA-Z0-9_\u4E00-\u9FA5]*)#)"

#define ImageNamePref @"Image/"
#define ImageNamePath(name) [ImageNamePref stringByAppendingString:name]

#import <Foundation/Foundation.h>

@interface UIAttributeItem : NSObject
{
    UIColor*    color_;
    UIFont*     font_;
}
@property (nonatomic, retain) UIColor*  color;
@property (nonatomic, retain) UIColor*  shadowColor;
@property (nonatomic, retain) UIFont*   font;

//+(UIAttributeItem*)attributeforStyle:(TextStyle)type;
//
//+(NSDictionary*)dicforTextStyle:(TextStyle)type;
//+(UIColor*)colorforColorStyle:(ColorStyle)type;

/// 生产当前图片存储Full路径
+ (NSString*)getCurrentUserPhotoSavePath;

+ (NSString*)parseIndexWishImageURL:(NSString*)url;

+ (NSString*)parseIndexWishSmallImageURL:(NSString*)url;

+ (NSString*)parseUserAvatarImageURL:(NSString*)url;

+ (NSString*)parseUserAvatarSmallImageURL:(NSString*)url;

+ (NSString*)parseGiftImageURL:(NSString*)url;

@end
