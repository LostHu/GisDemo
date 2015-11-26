//
//  PublicHeader.h
//  Wish
//
//  Created by lost on 15/7/13.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#ifndef Wish_Header_h
#define Wish_Header_h


#endif


//#import <UIKit/UIKit.h>


#define ImageFilePath(name) [@"Images/" stringByAppendingString:name]

#pragma mark - 屏幕 functions
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

#pragma mark - 系统参数 functions
#define SYSTEMVER_F [[[UIDevice currentDevice] systemVersion] floatValue]
#define SYSTEMVER ([[UIDevice currentDevice] systemVersion])
#define SYSteM_LANGUAGE ([[NSLocale preferredLanguages] objectAtIndex:0])
//ios系统版本
#define ios8x [[[UIDevice currentDevice] systemVersion] floatValue] >=8.0f
#define ios7x ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f) && ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0f)
#define ios6x [[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f
#define iosNot6x [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f

#define iphone4x_3_5 ([UIScreen mainScreen].bounds.size.height==480.0f)

#define iphone5x_4_0 ([UIScreen mainScreen].bounds.size.height==568.0f)

#define iphone6_4_7 ([UIScreen mainScreen].bounds.size.height==667.0f)

#define iphone6Plus_5_5 ([UIScreen mainScreen].bounds.size.height==736.0f || [UIScreen mainScreen].bounds.size.width==414.0f)


#ifdef __USE_SANDBOX__
    #define AppVersion [NSString stringWithFormat:@"测试_%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]]
#else
    #define AppVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#endif

#pragma mark - 颜色 functions
#define COLOR4RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define COLOR4RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// rgb颜色转换（16进制->10进制）
#define COLOR4HEX(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]
#define COLOR4HEXA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:(a)]

#pragma mark - 小技巧|优化 functions

#define FloatEqual(a,b) ((ABS(a-b)) < 0.000001)

// 安全释放
#define SAFE_RELEASE(x) { [x release]; x = nil; }

// 是否为空或是[NSNull null]
#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

// 打印出当前函数&行
#define MARK  NSLog(@"\nMARK: %s, %d", __PRETTY_FUNCTION__, __LINE__)
#define SelfClassName [NSString stringWithUTF8String:object_getClassName(self)]

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)


// 自定义ARC下的单例
#define DEFINE_SINGLETON_FOR_HEADER(className) \
\
+ (className *)sharedInstance;

#define DEFINE_SINGLETON_FOR_CLASS(className) \
\
__strong static className *_instance; \
+ (className *)sharedInstance { \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}\
+ (id)allocWithZone:(struct _NSZone *)zone{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
_instance = [super allocWithZone:zone];\
});\
return _instance;\
}\
-(id)copyWithZone:(NSZone *)zone{\
return _instance;\
}\
