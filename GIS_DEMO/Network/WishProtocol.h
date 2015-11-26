//
//  WishProtocol.h
//  Wish
//
//  Created by lost on 15/7/15.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#define WebSite @"http://www.xxx.com/"

#import <Foundation/Foundation.h>

typedef enum
{
    UploadImage = -1,       // 上传image
    Login = 0,              // 登录
    Register,
    
} ProtocolType;

@interface WishProtocol : NSObject
+(NSString*)GetURLforProtocol:(ProtocolType)protocol;
@end
