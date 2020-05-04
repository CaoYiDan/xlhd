//
//  BindShopViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2020/3/21.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "BindShopViewController.h"
#import "SWQRCode.h"

@interface BindShopViewController ()
@property (weak, nonatomic) IBOutlet UIButton *skip;

@end

@implementation BindShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"绑定商家";
}
//跳过点击
- (IBAction)skipClick:(id)sender {
    [[NSNotificationCenter defaultCenter]postNotificationName:@"RootVCChangeToHomeVC" object:nil];
}

- (IBAction)goBindBtnClick:(UIButton *)sender {
    SWQRCodeConfig *config = [[SWQRCodeConfig alloc]init];
    config.scannerType = SWScannerTypeBoth;
    SWQRCodeViewController *qrcodeVC = [[SWQRCodeViewController alloc]init];
    qrcodeVC.codeConfig = config;
    [self.navigationController pushViewController:qrcodeVC animated:YES];
    
}

@end
