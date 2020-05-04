//
//  CskczView.m
//  MTUserd
//
//  Created by 伯爵 on 2020/1/6.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "CskczView.h"
#import "CskczInfoView.h"

@implementation CskczView

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
           NSInteger cols = 1;
           //图片大小
           NSInteger viewW = ScreenWidth-20;
           NSInteger viewH = 44;
           
           //每一列的间距
           CGFloat colMargin = 10;
           
           //图片所在列
           NSInteger col = i % cols;
           //图片所在行
           NSInteger row = i / cols;
           
           CGFloat shopX = 0;
           CGFloat shopY = row * (viewH + colMargin);
           
      
           YkczModel *model = datas[i];

        CskczInfoView *view = [CskczInfoView loadFromNIB];
        view.frame = CGRectMake(shopX, shopY, viewW, viewH);
        view.chooseBtn.tag = i;
        view.tag = i;
        if (view.tag == 0) {
            [view setBorderLineWithColor:RGB(176, 216, 252)];
        }else{
            [view setBorderLineWithColor:RGB(241, 241, 241)];
        }
        view.goodLab.text = [NSString stringWithFormat:@"%@次 不限时",model.times];
        view.priceLab.text = [NSString stringWithFormat:@"￥%@",model.actual_price];
       [view.chooseBtn addTarget:self action:@selector(chooseBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.bgView addSubview:view];
        [self.viewArray addObject:view];
    }
}

- (void)chooseBtnClick:(UIButton *)btn{
    YkczModel *fModel = self.dataArray[btn.tag];
    self.goodId = fModel.goods_id;
    for (CskczInfoView *vi in self.viewArray) {
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
