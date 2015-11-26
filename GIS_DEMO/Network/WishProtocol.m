//
//  WishProtocol.m
//  Wish
//
//  Created by lost on 15/7/15.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "WishProtocol.h"

@implementation WishProtocol

+ (NSString*)GetURLforProtocol:(ProtocolType)protocol
{
    NSString* requestURL = @"";
    switch (protocol) {
        default:
            assert(@"没定义的url");
            break;
    }
    
    requestURL = [WebSite stringByAppendingString:requestURL];
    
    return requestURL;
}

@end
