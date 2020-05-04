//
//  TestViewController.m
//  FYLPageViewController
//
//  Created by FuYunLei on 2017/4/17.
//  Copyright © 2017年 FuYunLei. All rights reserved.
//

#import "TestViewController.h"
#import "JbczView.h"
#import "YkczView.h"
#import "YkczModel.h"
#import "BuyDcView.h"
#import "CskczView.h"
#import "YjczView.h"

@interface TestViewController ()

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

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];

//    UIColor *colorBg = [UIColor colorWithRed:getRandomNumber()/255.f green:getRandomNumber()/255.f blue:getRandomNumber()/255.f alpha:1.0];
//    self.view.backgroundColor = colorBg;
//
//
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 40)];
//    label.center = self.view.center;
//    label.textAlignment = NSTextAlignmentCenter;
//    label.text = [NSString stringWithFormat:@"第%zi个控制器",_index];
//    [self.view addSubview:label];
    

    if (_index == 1) {
        self.jbczView = [JbczView loadFromNIB];
        self.jbczView.frame = self.view.frame;
        [self.view addSubview:self.jbczView];
        [self requestJbData];
    }else if (_index == 2) {
        self.ykczView = [YkczView loadFromNIB];
        self.ykczView.frame = self.view.frame;
        [self.view addSubview:self.ykczView];
        [self requestDayData];
    }else if (_index == 3) {
        self.buyDcView = [BuyDcView loadFromNIB];
        self.buyDcView.frame = self.view.frame;
        [self.view addSubview:self.buyDcView];
        [self requestDcData];
    }else if (_index == 4) {
        self.cskczView = [CskczView loadFromNIB];
        self.cskczView.frame = self.view.frame;
        [self.view addSubview:self.cskczView];
        [self requestCskData];
    }else if (_index == 5) {
        self.yjczView = [YjczView loadFromNIB];
        self.yjczView.frame = self.view.frame;
        [self.view addSubview:self.yjczView];
        [self requestYjData];
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
