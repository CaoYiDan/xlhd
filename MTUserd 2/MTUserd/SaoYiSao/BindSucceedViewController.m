//
//  BindSucceedViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2020/1/14.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "BindSucceedViewController.h"

@interface BindSucceedViewController ()

@property (weak, nonatomic) IBOutlet UIButton *xianxiajnBtn;

@end

@implementation BindSucceedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定商家";
    [self setupView];
}

- (void)setupView{
    [self.xianxiajnBtn setBorderLineWithColor:RGB(114, 115, 116)];
    
}

@end
