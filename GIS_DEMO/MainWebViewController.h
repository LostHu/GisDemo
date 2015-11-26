//
//  DPWebViewController.h
//  Wish
//
//  Created by Lost on 15/8/17.
//  Copyright (c) 2015年 lost. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainWebViewController : UIViewController<UIWebViewDelegate>
{
    UIWebView *_webView;
}

@property(nonatomic,copy) NSURL *stringURL;

@end
