//
//  TopupDetailViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2020/1/6.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "TopupDetailViewController.h"
#import "OrderDetailModel.h"

@interface TopupDetailViewController ()
{
    NSString *payTypeStr;
}
@property (weak, nonatomic) IBOutlet UILabel *priceLab;
@property (weak, nonatomic) IBOutlet UILabel *typeLab;
@property (weak, nonatomic) IBOutlet UILabel *orderSnLab;
@property (weak, nonatomic) IBOutlet UIButton *wxBtn;
@property (weak, nonatomic) IBOutlet UIButton *zfbBtn;

@property (nonatomic ,strong)OrderDetailModel *model;

@end

@implementation TopupDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"充值";
    payTypeStr = @"wx";
    [self requestData];
}

- (void)requestData{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.orderSn forKey:@"order_sn"];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@order/get",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.model = [OrderDetailModel yy_modelWithJSON:dict[@"data"]];
            [self setupUI];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)setupUI{
    
    self.orderSnLab.text = self.model.order_sn;
    self.priceLab.text = [NSString stringWithFormat:@"%@",self.model.goods[0][@"actual_price"]];
    self.typeLab.text = self.model.goods[0][@"goods_name"];
}

- (IBAction)choosePayTypeBtnClick:(id)sender {
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 100) {
        payTypeStr = @"wx";
        [_wxBtn setImage:[UIImage imageNamed:@"chenggong"] forState:UIControlStateNormal];
        [_zfbBtn setImage:[UIImage imageNamed:@"nochenggong"] forState:UIControlStateNormal];
    }else{
        payTypeStr = @"zfb";
        [_zfbBtn setImage:[UIImage imageNamed:@"chenggong"] forState:UIControlStateNormal];
        [_wxBtn setImage:[UIImage imageNamed:@"nochenggong"] forState:UIControlStateNormal];
    }
}

- (IBAction)buyBtnClick:(UIButton *)sender {

    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.orderSn forKey:@"order_sn"];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@pay/order",base_url] param:jsonStr success:^(NSDictionary *dict) {           
        if ([dict[@"errorCode"]intValue] == 0) {
            if ([self->payTypeStr isEqualToString:@"zfb"]) {
                NSString *appScheme = @"ap2021001108683592";
                NSString * orderString = dict[@"data"][@"pay_sign"];
                // NOTE: 调用支付结果开始支付
                [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
                NSString * memo = resultDic[@"memo"];
                if ([resultDic[@"ResultStatus"] isEqualToString:@"9000"]) {
                    
                    
                    Toast(@"支付完毕");
                    [self .navigationController popViewControllerAnimated:YES];
               
                }else{
                    
                    [self showHint:memo];
                    
                }
                                   
            }];
        }
        
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
    }];
}

@end
