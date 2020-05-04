//
//  JbczView.m
//  MTUserd
//
//  Created by 伯爵 on 2019/12/24.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "JbczView.h"
#import "JbczInfoView.h"

@implementation JbczView

- (void)getDataWithInfo:(NSArray *)datas{
    self.buyBtn.hidden = NO;
    self.dataArray = datas;
    YkczModel *fModel = datas[0];
    self.goodId = fModel.goods_id;
    self.viewArray = [NSMutableArray array];
    float a = (float)datas.count/2;;
    self.bgViewHeight.constant = ceil(a)*75;
    for (NSInteger i = 0; i < datas.count; i++) {
           //一行的列数
        NSInteger cols = 2;
           //图片大小
        NSInteger viewW = (ScreenWidth-30)/2;
        NSInteger viewH = 65;
           
           //每一列的间距
        CGFloat colMargin = 10;
           
           //图片所在列
        NSInteger col = i % cols;
           //图片所在行
        NSInteger row = i / cols;
           
        CGFloat shopX = col * (viewW + colMargin);
        CGFloat shopY = row * (viewH + colMargin);
      
        YkczModel *model = datas[i];

        JbczInfoView *view = [JbczInfoView loadFromNIB];
        view.frame = CGRectMake(shopX, shopY, viewW, viewH);
        view.goodLab.text = [NSString stringWithFormat:@"%@金币",model.gold];
        view.xPriceLab.text = [NSString stringWithFormat:@"￥%@",model.actual_price];
        view.oldPriceLab.text = [NSString stringWithFormat:@"原价：%@",model.market_price];
        view.chooseBtn.tag = i;
        view.tag = i;
        if (view.tag == 0) {
            [view setBorderLineWithColor:RGB(176, 216, 252)];
        }else{
            [view setBorderLineWithColor:RGB(241, 241, 241)];
        }
        [view.chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:view];
        [self.viewArray addObject:view];
    }
}

- (void)chooseBtnClick:(UIButton *)btn{
    YkczModel *fModel = self.dataArray[btn.tag];
    self.goodId = fModel.goods_id;
    for (JbczInfoView *vi in self.viewArray) {
        if (vi.tag == btn.tag) {
            [vi setBorderLineWithColor:RGB(176, 216, 252)];
        }else{
            [vi setBorderLineWithColor:RGB(241, 241, 241)];
        }
    }
}

- (IBAction)buyBtnClick:(UIButton *)sender {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.goodId forKey:@"goods_id"];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@order/recharge",base_url] param:jsonStr success:^(NSDictionary *dict) {            
        if ([dict[@"errorCode"]intValue] == 0) {
            TopupDetailViewController *topupDetailVC = [[TopupDetailViewController alloc]init];
            topupDetailVC.orderSn = dict[@"data"][@"order_sn"];
            [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:topupDetailVC animated:YES];
        }else{
        }
    } fail:^(NSError *error) {
    }];
    
}

@end
