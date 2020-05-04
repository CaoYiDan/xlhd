//
//  ContactUsViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2020/1/15.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "ContactUsViewController.h"

@interface ContactUsViewController ()

@end

@implementation ContactUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"联系我们";
    self.view.backgroundColor = [UIColor whiteColor];
    NSString *str = @"http://xlhdh5.zhixingonline.com/h5/contact";
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
