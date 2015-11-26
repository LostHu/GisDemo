//
//  ZipManager.h
//  GIS_DEMO
//
//  Created by lost on 15/11/23.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^DownloadFileRespondBlcok)(BOOL success);

@interface ZipManager : NSObject
- (void)initMainData;
- (void)downloadFile1;
- (void)downloadFile2;
- (void)httpDownloadZipData:(NSString*)fileUrl result:(DownloadFileRespondBlcok)result;
@end
