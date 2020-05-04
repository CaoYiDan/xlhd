//
//  FltkViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/12.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "FltkViewController.h"

@interface FltkViewController ()

@end

@implementation FltkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"法律条款及协议";
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *str = @"http://xlhdh5.zhixingonline.com/h5/clause";
    str = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-64)];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:webView];
    
    for (UIView *subView in [webView subviews])
    {
        if ([subView isKindOfClass:[UIScrollView class]])
        {
            // 不显示竖直的滚动条
            [(UIScrollView *)subView setShowsVerticalScrollIndicator:NO];
        }
    }
}

@end
