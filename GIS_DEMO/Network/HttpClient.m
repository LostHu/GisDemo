//
//  HttpClient.m
//  WLY_Owner
//
//  Created by lost on 15/11/2.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "HttpClient.h"
#import "WishProtocol.h"


@implementation HttpClient

DEFINE_SINGLETON_FOR_CLASS(HttpClient)

-(void)startBlockGetUrl:(ProtocolType)protocol
               fromData:(NSMutableDictionary *)data
                  block:(HttpRespondBlcok)result
{
    NSString* requestURL = [WishProtocol GetURLforProtocol:protocol];;
    
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:requestURL parameters:data success:^(AFHTTPRequestOperation * operation, id responseObject) {
        
        NSLog(@"Get success______");
        
        NSString *requestTmp = [NSString stringWithString:operation.responseString];
        if ([NSString isBlankString:requestTmp]) {
            if (result) {
                result(nil);
            }
            return;
        }
        
        NSData* resData = [[NSData alloc] initWithData:[requestTmp dataUsingEncoding:NSUTF8StringEncoding]];
        
        if (!resData) {
            if (result) {
                result(nil);
            }
            return;
        }
        
        JSONDecoder* jsonDecoder = [JSONDecoder new];
        NSError* error = nil;
        id reptr = [jsonDecoder objectWithData:resData error:&error];
        if (!reptr) {
            if (result) {
                result(nil);
            }
            return;
        }
        
        NSDictionary* dic = reptr;
        if (!(dic && [dic isKindOfClass:[NSDictionary class]])) {
            if (result) {
                result(nil);
            }
            return;
        }
        
        
        if (result) {
            result(dic);
        }
        
        
    } failure:^(AFHTTPRequestOperation * operation, NSError * error) {
        
        NSLog(@"Get failure_____%@",error);
        if (result) {
            result(nil);
        }
    }];
}

- (void)startDownLoadUrl:(NSString*)requestURL
                 filePath:(NSString*)fullPath
                fromData:(NSDictionary*)data
                  result:(HttpDownloadRespondBlcok)result
                progress:(HttpDownloadProgress)progress

{
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:config];
    
    requestURL = [requestURL stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:requestURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    NSURLSessionDownloadTask *task = [manager downloadTaskWithRequest:request progress:nil destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        NSLog(@"%@ %@", filePath, error);
        if (!error && result)
        {
            result(YES);
        }
    }];
    
    [task resume];
    
    return;
}

@end
