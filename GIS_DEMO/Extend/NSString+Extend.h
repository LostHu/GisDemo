//
//  NSString+Extend.h
//  Wish
//
//  Created by lost on 15/7/13.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extend)

/**
 *  32位MD5加密
 */
@property (nonatomic,copy,readonly) NSString *md5;


/**
 *  SHA1加密
 */
@property (nonatomic,copy,readonly) NSString *sha1;


+ (NSString*)encodeBase64String:(NSString *)input;
+ (NSString*)decodeBase64String:(NSString *)input;
+ (NSString*)encodeBase64Data:(NSData *)data;
+ (NSString*)decodeBase64Data:(NSData *)data;

- (NSString *)URLEncodedStringTranslate;
- (NSString *)URLEncodedString;

+ (BOOL)isBlankString:(NSString *)string;
+ (BOOL)isMobileNumber:(NSString *)mobileNum;

@end
