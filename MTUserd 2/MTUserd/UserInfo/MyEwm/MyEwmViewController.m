//
//  MyEwmViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/15.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "MyEwmViewController.h"

@interface MyEwmViewController ()


@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation MyEwmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的二维码";
    [self setupView];
}

- (void)setupView{
    [self.saveBtn setBorderLineWithColor:RGB(194, 200, 208)];
}

@end
