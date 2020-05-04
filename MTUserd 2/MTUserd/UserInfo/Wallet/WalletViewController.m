//
//  WalletViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/12.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "WalletViewController.h"
#import "OrderViewController.h"
#import "WalletInfoModel.h"
#import "JbczView.h"
#import "YkczView.h"
#import "YkczModel.h"
#import "BuyDcView.h"
#import "CskczView.h"
#import "YjczView.h"
#import "HdjlViewController.h"
#import "WalletTopView.h"

@interface WalletViewController ()
{
    WalletTopView *yajinView;
}
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UIView *moveView;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;
@property (weak, nonatomic) IBOutlet UIImageView *logoImg;
@property (nonatomic ,strong)WalletInfoModel *model;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (nonatomic ,strong)JbczView *jbczView;
@property (nonatomic ,strong)YkczView *ykczView;
@property (nonatomic ,strong)BuyDcView *buyDcView;
@property (nonatomic ,strong)CskczView *cskczView;
@property (nonatomic ,strong)YjczView *yjczView;

@property (nonatomic ,strong)NSArray *dayDataArray;
@property (nonatomic ,strong)NSArray *jbDataArray;
@property (nonatomic ,strong)NSArray *dcDataArray;
@property (nonatomic ,strong)NSArray *cskDataArray;
@property (nonatomic ,strong)NSArray *yjDataArray;


@end

@implementation WalletViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的钱包";
   
    self.jbczView = [JbczView loadFromNIB];
    self.jbczView.frame = CGRectMake(0, 0, ScreenWidth, self.bgView.height);
    [self.bgView addSubview:self.jbczView];
    
    [self requestJbData];
    
    [self requestData];
    [self ykczView];
}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@user/wallet",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.model = [WalletInfoModel yy_modelWithJSON:dict[@"data"]];
            self.countLab.text = self.model.gold;

        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
//         NSLog(@"%@",error);
    }];
    
}

- (IBAction)chooseBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100:
            [yajinView removeFromSuperview];
            [self.jbczView removeFromSuperview];
            self.logoImg.image = [UIImage imageNamed:@"139c23140d0cb"];
            self.titleLab.text = @"金币数量(个)";
            self.countLab.text = self.model.gold;
            self.jbczView = [JbczView loadFromNIB];
            self.jbczView.frame = CGRectMake(0, 0, ScreenWidth, self.bgView.height);
            [self.bgView addSubview:self.jbczView];
            [self requestJbData];

            break;
        case 200:
            [yajinView removeFromSuperview];
            [self.ykczView removeFromSuperview];
            self.logoImg.image = [UIImage imageNamed:@"rili"];
            self.titleLab.text = @"月卡剩余(天)";
            self.countLab.text = self.model.days;
            
            self.ykczView = [YkczView loadFromNIB];
            self.ykczView.frame = CGRectMake(0, 0, ScreenWidth, self.bgView.height);
            [self.bgView addSubview:self.ykczView];
            [self requestDayData];

            break;
        case 300:
            [yajinView removeFromSuperview];
            [self.buyDcView removeFromSuperview];
            self.logoImg.image = [UIImage imageNamed:@"qianbaodianchi"];
            self.titleLab.text = @"购买电池";
            self.countLab.text = @"";
            
            self.buyDcView = [BuyDcView loadFromNIB];
            self.buyDcView.frame = CGRectMake(0, 0, ScreenWidth, self.bgView.height);
            [self.bgView addSubview:self.buyDcView];
            [self requestDcData];
            break;
        case 400:
            [yajinView removeFromSuperview];
            [self.cskczView removeFromSuperview];
            self.logoImg.image = [UIImage imageNamed:@"cishuka"];
            self.titleLab.text = @"次数卡(次)";
            self.countLab.text = self.model.times;
            self.cskczView = [CskczView loadFromNIB];
            self.cskczView.frame = CGRectMake(0, 0, ScreenWidth, self.bgView.height);
            [self.bgView addSubview:self.cskczView];
            [self requestCskData];
            break;
        case 500:
        {
            yajinView = [WalletTopView loadFromNIB];
            yajinView.frame = CGRectMake(0, 0, ScreenWidth, 130);
            [self.view addSubview:yajinView];
            [self.yjczView removeFromSuperview];
//            self.logoImg.image = [UIImage imageNamed:@"yajin"];
//            self.titleLab.text = @"押金";
//            self.countLab.text = self.model.deposit;
            if (self.model.deposit_status == 0) {
                yajinView.yajinLab.text = @"押金未缴纳";
            }else{
                yajinView.yajinLab.text = @"押金已缴纳";
            }
            self.yjczView = [YjczView loadFromNIB];
            self.yjczView.frame = CGRectMake(0, 0, ScreenWidth, self.bgView.height);
            [self.bgView addSubview:self.yjczView];
            [self requestYjData];
        }
            break;
        default:
            break;
    }
    [UIView animateWithDuration:0.3 animations:^{
        self.moveView.centerX = sender.centerX;
    }];
    for (UIButton *btn in self.buttons) {
        if (sender == btn) {
            [btn setTitleColor:mainColor forState:UIControlStateNormal];
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
}

- (IBAction)orderBtnClick:(UIButton *)sender {
    if (sender.tag == 100) {
        HdjlViewController *hdjlVC = [[HdjlViewController alloc]init];
        [self.navigationController pushViewController:hdjlVC animated:YES];
    }else{
        OrderViewController *orderVC = [[OrderViewController alloc]init];
        [self.navigationController pushViewController:orderVC animated:YES];
    }
}


- (void)requestJbData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@goods/recharge-gold",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.jbDataArray = [NSArray yy_modelArrayWithClass:[YkczModel class] json:dict[@"data"]];
            [self.jbczView getDataWithInfo:self.jbDataArray];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
//         NSLog(@"%@",error);
    }];
    
}

- (void)requestDayData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@goods/recharge-days",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dayDataArray = [NSArray yy_modelArrayWithClass:[YkczModel class] json:dict[@"data"]];
            [self.ykczView getDataWithInfo:self.dayDataArray];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
    }];
    
}

- (void)requestDcData{

    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@goods/recharge-battery-buy",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
           
            self.dcDataArray = [NSArray yy_modelArrayWithClass:[YkczModel class] json:dict[@"data"]];
            [self.buyDcView getDataWithInfo:self.dcDataArray];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
    }];
    
}

- (void)requestCskData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@goods/recharge-times",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.cskDataArray = [NSArray yy_modelArrayWithClass:[YkczModel class] json:dict[@"data"]];
            [self.cskczView getDataWithInfo:self.cskDataArray];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
    }];
    
}

- (void)requestYjData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@goods/recharge-battery-deposit",base_url] param:jsonStr success:^(NSDictionary *dict) {        
        if ([dict[@"errorCode"]intValue] == 0) {
            self.cskDataArray = [NSArray yy_modelArrayWithClass:[YkczModel class] json:dict[@"data"]];
            YkczModel *model = self.cskDataArray[0];
            self.yjczView.priceLab.text = model.actual_price;
//            [self.cskczView getDataWithInfo:self.cskDataArray];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
    }];
    
}

@end
