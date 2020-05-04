//
//  BuyDcView.m
//  MTUserd
//
//  Created by 伯爵 on 2020/1/6.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "BuyDcView.h"
#import "BuyDcInfoView.h"

@implementation BuyDcView
{
    NSInteger _selectedIndex;
    BuyDcInfoView *_selectedCell;//选中的"cell"
}
- (void)getDataWithInfo:(NSArray *)datas{
    self.buyBtn.hidden = NO;
    YkczModel *fModel = datas[0];
    self.goodId = fModel.goods_id;
    _selectedIndex = 0;
    float a = (float)datas.count;
    self.bgViewHeight.constant = ceil(a)*55;
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

        BuyDcInfoView *view = [BuyDcInfoView loadFromNIB];
        view.frame = CGRectMake(shopX, shopY, viewW, viewH);
        view.goodLab.text = @"购买电池";
        view.tag = i;
        view.priceLab.text = [NSString stringWithFormat:@"￥%@",model.actual_price];

        view.userInteractionEnabled = YES;
        
        UIButton *clickBtn = [[UIButton alloc]init];
        clickBtn.backgroundColor = [UIColor clearColor];
        [view addSubview:clickBtn];
        clickBtn.tag = i;
        [clickBtn addTarget:self action:@selector(selectedCell:) forControlEvents:UIControlEventTouchUpInside];
        [clickBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.offset(0);
        }];
        if (i==0) {
            _selectedCell = view;
            _selectedCell.layer.borderColor = RGB(9, 141, 250).CGColor;
            _selectedCell.layer.borderWidth = 0.5f;
        }
        
           [self.bgView addSubview:view];
         
       }
}

-(void)selectedCell:(UIButton *)btn{
    
   _selectedCell.layer.borderColor = RGB(235, 244, 252).CGColor;
      _selectedCell.layer.borderWidth = 0.5f;
      
    
    _selectedCell = (BuyDcInfoView *)btn.superview;
    
    _selectedCell.layer.borderColor = RGB(9, 141, 250).CGColor;
       _selectedCell.layer.borderWidth = 0.5f;
       
    
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
