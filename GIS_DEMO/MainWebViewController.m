//
//  DPWebViewController.m
//  Wish
//
//  Created by Lost on 15/8/17.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import "MainWebViewController.h"
#import "MapDataViewController.h"
#import "UIColor+Extend.h"
#import "PublicHeader.h"
#import "UINavigationBar+Extend.h"
#import "UserInfoViewController.h"
#import "WebBottomView.h"
#import "ZipManager.h"

@interface MainWebViewController ()<changeSelectDelegate>
{
    WebBottomView* _bottomView;
    
    BOOL _bLoaded;
}

@end

@implementation MainWebViewController

- (NSString *)htmlDirPath
{
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    //    NSLog(@"%@",filePath);
    NSString *htmlDirPath = [documentPath stringByAppendingPathComponent:@"/mainmap"];
    return htmlDirPath;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"浦东供电局";
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor orangeColor],NSForegroundColorAttributeName,[UIFont fontWithName:@"STHeitiSC-Medium" size:22.0],NSFontAttributeName,nil]];
    [self.navigationController.navigationBar setBottomBorderColor:[UIColor orangeColor] height:1];
    
    //去除系统默认的返回字眼
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    
    
    if (!_bottomView) {
        _bottomView = [[ WebBottomView alloc ] init];
        [self.view addSubview:_bottomView];
    }
    
    [_bottomView setData:@"浦东供电局"];
    _bottomView.backgroundColor = [UIColor whiteColor];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 40));
        make.bottom.equalTo(self.view.mas_bottom);
        make.centerX.equalTo(self.view);
    }];
    
    
    CGRect mainBounds = [[UIScreen mainScreen] bounds];
    mainBounds.size.height -= 44;
    if (!_webView) {
        _webView = [[ UIWebView alloc ] initWithFrame:mainBounds];
        [self.view addSubview:_webView];
    }
   
    _webView.scalesPageToFit = YES;
    _webView.delegate = self;
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(_bottomView.mas_top);
    }];

    
    NSString* path = [[self htmlDirPath] stringByAppendingString:@"/mainmap.html"];
    NSURL* url = [NSURL fileURLWithPath:path];
    
    NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
    [_webView loadRequest:request];
    
    UIBarButtonItem * leftButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:ImageFilePath(@"nav_more.png")] style:UIBarButtonItemStylePlain target:self action:@selector(selectMap)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIBarButtonItem * rightButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:ImageFilePath(@"nav_user.png")] style:UIBarButtonItemStylePlain target:self action:@selector(showUserInfo)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
    BOOL isDirectory;
    BOOL bHas = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    // 检查是否存在html根目录
    if (!bHas) {
        [MBProgressHUD showMessage:@"数据为空,请更新数据" view:self.view];
    }
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    _bLoaded = YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"%@",error);
    _bLoaded = NO;
}

- (void)showUserInfo
{
    UserInfoViewController* fViewController = [[UserInfoViewController alloc] init];
    fViewController.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:fViewController animated:YES];
}

- (void)selectMap
{
    MapDataViewController* fViewController = [[MapDataViewController alloc] init];
    fViewController.hidesBottomBarWhenPushed = YES;
    fViewController.delegate = self;
    [self.navigationController pushViewController:fViewController animated:YES];
}

- (void)dealloc
{
    _webView.delegate = nil;
    self.stringURL = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)changeSelect:(MapData *)map
{
    // 上一次加载失败,需要刷新一下
    if (!_bLoaded) {
        NSString* path = [[self htmlDirPath] stringByAppendingString:@"/mainmap.html"];
        NSURL* url = [NSURL fileURLWithPath:path];
        
        NSURLRequest* request = [NSURLRequest requestWithURL:url] ;
        [_webView loadRequest:request];
    }
    
    if (_bottomView) {
        [_bottomView setData:[NSString stringWithFormat:@"%@%@(%@)",map.drawingType,map.drawingDir,map.managementUnit]];
    }
    
    NSString* parmOrin = [NSString stringWithFormat:@"%@%@",map.drawingType,[map.name integerValue]%2 == 1 ? @"b1" : @"b2"];
    NSString* parm = [NSString stringWithFormat:@"refreshMap('%@');",parmOrin];
    [_webView stringByEvaluatingJavaScriptFromString:parm];
}

@end
