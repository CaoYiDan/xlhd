//
//  AddryViewController.m
//  MTYunWeiShang
//
//  Created by 伯爵 on 2020/2/8.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "AddryViewController.h"

@interface AddryViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameLab;
@property (weak, nonatomic) IBOutlet UITextField *accountLab;
@property (weak, nonatomic) IBOutlet UITextField *pswLab;

@end

@implementation AddryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加账号";
}

- (IBAction)addBtnClick:(UIButton *)sender {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.accountLab.text forKey:@"phone_number"];
    [param setValue:self.nameLab.text forKey:@"name"];
    [param setValue:self.pswLab.text forKey:@"password"];
    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@tse/create",base_url] param:jsonStr success:^(NSDictionary *dict){
        if ([dict[@"errorCode"]intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [[[Singleton shardeManger]getCurrentVC] showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
         NSLog(@"%@",error);
    }];
}


@end
