//
//  MySelfAnnotationView.h
//  MTUserd
//
//  Created by MAC on 2020/4/23.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MySelfAnnotationView : MAAnnotationView

/** <#Description#> */
@property (nonatomic, weak) UILabel *batteriesNumLab;
/** <#Description#> */
@property (nonatomic, weak) UIImageView *batteryImgView;


-(void)setBatteriesNum:(NSString *)batteriesNum;

@end

NS_ASSUME_NONNULL_END
