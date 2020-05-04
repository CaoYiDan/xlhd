
//
//  CustomAnnotationView.m
//  MTUserd
//
//  Created by 伯爵 on 2019/12/27.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "CustomAnnotationView.h"
#define kCalloutWidth       200.0
#define kCalloutHeight      70.0
@implementation CustomAnnotationView

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (self.calloutView == nil)
        {
            self.calloutView = [[CustomCalloutView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//            self.calloutView.center = CGPointMake(CGRectGetWidth(self.bounds) / 2.f + self.calloutOffset.x,
//                                                  -CGRectGetHeight(self.calloutView.bounds) / 2.f + self.calloutOffset.y);
        }
        self.calloutView.countLab.text = @"5";
//        self.calloutView.image = [UIImage imageNamed:@"building"];
//        self.calloutView.title = self.annotation.title;
//        self.calloutView.subtitle = self.annotation.subtitle;
        
        [self addSubview:self.calloutView];
    }
    else
    {
        [self.calloutView removeFromSuperview];
    }
    
    [super setSelected:selected animated:animated];
}

@end
