//
//  HttpClient.h
//  WLY_Owner
//
//  Created by lost on 15/11/2.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PublicHeader.h"
#import "WishProtocol.h"

typedef void(^HttpRespondBlcok)(id data);
typedef void(^UploadFileResult)(NSString *uploadPath);
typedef void(^UploadFileProgress)(CGFloat progress);
typedef void(^HttpDownloadRespondBlcok)(BOOL success);
typedef void(^HttpDownloadProgress)(CGFloat progress);

@interface HttpClient : NSObject

DEFINE_SINGLETON_FOR_HEADER(HttpClient)

-(void)startBlockGetUrl:(ProtocolType)protocol
               fromData:(NSMutableDictionary *)data
                  block:(HttpRespondBlcok)result;

- (void)startDownLoadUrl:(NSString*)requestURL
                filePath:(NSString*)fullPath
                fromData:(NSDictionary*)data
                  result:(HttpDownloadRespondBlcok)result
                progress:(void (^)(CGFloat progress))progress;

@end