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
     [self addSubview:self.batteriesNumLab];
}
- (UILabel *)batteriesNumLab{
    if (!_batteriesNumLab) {
        UILabel *batteriesNum = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 54, 54)];
        batteriesNum.textColor= [UIColor whiteColor];
        batteriesNum.font = [UIFont systemFontOfSize:17];
        
        batteriesNum.textAlignment = NSTextAlignmentCenter;
       [self.imageView addSubview:batteriesNum];
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
    
  
//
}

- (void)setBatteriesNum:(NSString *)batteriesNum{
    
    if ([batteriesNum isEqualToString:@"当前位置"]) {
        
        self.batteryImgView.hidden = YES;
        self.batteriesNumLab.hidden = YES;
        self.batteriesNumLab.text = @"";
        self.image = [UIImage imageNamed:@"location-4"];
          
    }else{
        
        self.batteryImgView.hidden = YES;
        self.batteriesNumLab.hidden = NO;
        self.batteriesNumLab.text = @"电柜";
        self.image = [UIImage imageNamed:@"dtzImg"];
          
    }
   
}

- (void)dealloc
{
    
}
@end
