//
//  MySelfAnnotationView.m
//  MTUserd
//
//  Created by MAC on 2020/4/23.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "MySelfAnnotationView.h"

@implementation MySelfAnnotationView



- (void)setSelected:(BOOL)selected{
    [super setSelected:selected];
//    [self setUI];
}
- (UILabel *)batteriesNumLab{
    if (!_batteriesNumLab) {
        UILabel *batteriesNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 14, 54, 20)];
        batteriesNum.textColor= [UIColor whiteColor];
        batteriesNum.font = [UIFont systemFontOfSize:17];
        batteriesNum.textAlignment = NSTextAlignmentCenter;
        [self addSubview:batteriesNum];
        _batteriesNumLab = batteriesNum;
    }
    return _batteriesNumLab;
}

- (UILabel *)batteryImgView{
    if (!_batteryImgView) {
        UIImageView *batteryImg = [[UIImageView alloc]initWithFrame:CGRectMake(20, 14+21, 14, 8)];
        batteryImg.image = [UIImage imageNamed:@"batteryls"];
        _batteryImgView = batteryImg;
        [self addSubview:batteryImg];
    }
    return _batteryImgView;
}

-(void)setUI{
    
  
    [self.batteriesNumLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        make.top.offset(14);
        make.right.offset(0);
        make.height.offset(15);
    }];
    
    [self.batteryImgView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.top.equalTo(self.batteriesNumLab.mas_bottom).offset(4);
           make.width.offset(14);
        make.centerX.offset(0);
           make.height.offset(8);
       }];
}

- (void)setBatteriesNum:(NSString *)batteriesNum{
    if ([batteriesNum isEqualToString:@"当前位置"]) {
        self.batteryImgView.hidden = YES;
        self.batteriesNumLab.hidden = YES;
        self.batteriesNumLab.text = @"";
        self.image = [UIImage imageNamed:@"location"];
          
    }else{
        
        self.batteryImgView.hidden = NO;
        self.batteriesNumLab.hidden = NO;
        self.batteriesNumLab.text = batteriesNum;
        self.image = [UIImage imageNamed:@"dtzImg"];
          
    }
   
}

- (void)dealloc
{
    
}
@end
