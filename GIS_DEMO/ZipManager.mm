//
//  ZipManager.m
//  GIS_DEMO
//
//  Created by lost on 15/11/23.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "ZipManager.h"
#import "ZipArchive.h"

@implementation ZipManager

- (NSString *)htmlDirPath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
//    NSLog(@"%@",filePath);
    NSString *htmlDirPath = [documentPath stringByAppendingPathComponent:@"/mainmap"];
    return htmlDirPath;
}

- (NSString *)downloadDirPath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    //    NSLog(@"%@",filePath);
    NSString *htmlDirPath = [documentPath stringByAppendingPathComponent:@"/download"];
    return htmlDirPath;
}

- (void)initMainData
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *homePath = [filePath objectAtIndex:0];
    
    NSString* dirPath = [self htmlDirPath];
    NSString* zipPath = [[NSBundle mainBundle] pathForResource:@"mainmap" ofType:@"zip" inDirectory:@""];
    
    BOOL isDirectory;
    BOOL bHas = [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDirectory];
    // 检查是否存在html根目录
    if (!bHas) {
        ZipArchive* zip = [[ZipArchive alloc] init];
        NSString* l_zipfile = zipPath;
        NSString* unzipto = homePath;
        if( [zip UnzipOpenFile:l_zipfile] ) {
            BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
            if( NO==ret ) { }
            [zip UnzipCloseFile];
        }
    }
    
    // 检查是否存在下载目录
    dirPath = [self downloadDirPath];
    bHas = [[NSFileManager defaultManager] fileExistsAtPath:dirPath isDirectory:&isDirectory];
    if (!bHas) {
        // 创建目录
        BOOL res=[[NSFileManager defaultManager] createDirectoryAtPath:dirPath withIntermediateDirectories:YES attributes:nil error:nil];
        if (res) {
            NSLog(@"文件夹创建成功");
        }else
            NSLog(@"文件夹创建失败");
    }
}

- (void)httpDownloadZipData:(NSString*)fileUrl result:(DownloadFileRespondBlcok)result
{
    NSString *saveFiltPath = [[self downloadDirPath] stringByAppendingString:[NSString stringWithFormat:@"/%@",[fileUrl lastPathComponent]]];
    NSString *upzipFilePath = [[self htmlDirPath] stringByAppendingPathComponent:@"/tiles"];
    
    [[HttpClient sharedInstance] startDownLoadUrl:fileUrl
                                         filePath:saveFiltPath
                                         fromData:nil result:^(BOOL success) {
        if (success) {
            ZipArchive* zip = [[ZipArchive alloc] init];
            NSString* l_zipfile = saveFiltPath;
            NSString* unzipto = upzipFilePath;
            if( [zip UnzipOpenFile:l_zipfile] ) {
                BOOL ret = [zip UnzipFileTo:unzipto overWrite:YES];
                if( NO==ret ) { }
                [zip UnzipCloseFile];
            }
            
            if (result) {
                result(YES);
            }
        }
         else
         {
             if (result) {
                 result(NO);
             }
         }
        
    } progress:^(CGFloat progress) {
        ;
    }];
}

@end
