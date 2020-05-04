//
//  CustomAnnotationView.h
//  MTUserd
//
//  Created by 伯爵 on 2019/12/27.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomCalloutView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomAnnotationView : MAAnnotationView

@property (nonatomic, strong, readwrite) CustomCalloutView *calloutView;

@end

NS_ASSUME_NONNULL_END
