//
//  QuitLeaseCell.m
//  MTShopd
//
//  Created by MAC on 2020/4/22.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "QuitLeaseCell.h"

@implementation QuitLeaseCell
{
    UILabel *_name;
    UILabel *_phone;
    UILabel *_bindTime;
    UILabel *_removeBindTime;
    UILabel *_haveQuitBattery;
}

- (void)initUI{
    
    
    ls_label(name, @"san", RGB(102, 102, 102), m_FontPF_Regular_WithSize(16),[UIColor whiteColor], 0, self, {
        make.left.offset(12);
        make.top.equalTo(self).offset(18);
        make.height.offset(22);
    });
    _name = nameLabel;
    
    ls_label(tel, @"***123", m_Color_RGB(102, 102, 102), m_FontPF_Regular_WithSize(14),[UIColor whiteColor], 0, self, {
        make.left.equalTo(_name.mas_right).offset(10);
        makeTopOffSet(_name, 0);
        make.height.offset(22);
    })
    _phone = telLabel;
    
    ls_label(bind, @"***123", m_Color_RGB(102, 102, 102), m_FontPF_Regular_WithSize(13),[UIColor whiteColor], 0, self, {
        make.left.equalTo(_name).offset(0);
        makeTopOffSet(_name.mas_bottom, 10);
        make.height.offset(18);
    })
    _bindTime = bindLabel;
    
    ls_label(remove, @"23", m_Color_RGB(250, 134, 9), m_FontPF_Regular_WithSize(13),[UIColor whiteColor], 0, self, {
        make.left.equalTo(_name).offset(0);
        makeTopOffSet(bindLabel.mas_bottom, 5);
        make.height.offset(18);
    })
    _removeBindTime = removeLabel;
    
    ls_label(quitNum, @"已退电池", m_Color_RGB(250, 134, 9), m_FontPF_Regular_WithSize(14),[UIColor whiteColor], NSTextAlignmentCenter, self, {
        make.right.equalTo(self).offset(-12);
        make.centerY.offset(0);
        make.width.offset(70);
        make.height.offset(32);
    })
    ls_cornerRadius(quitNumLabel, 8);
    quitNumLabel.layer.borderColor = KmainColor_ls.CGColor;
    quitNumLabel.layer.borderWidth = 1;
    _haveQuitBattery = quitNumLabel;

    
}

- (void)setFrame:(CGRect)frame{
    
    CGRect oldFrame = frame;
    CGFloat cellmargin = 10;
    CGRect newFrame = CGRectMake(oldFrame.origin.x+cellmargin, oldFrame.origin.y+10, oldFrame.size.width-2*cellmargin, oldFrame.size.height-10);
    //阴影偏移效果 - wsx注释
//    self.layer.shadowColor = [UIColor blueColor].CGColor;
//    self.layer.shadowOffset = CGSizeMake(1, 1);
//    self.layer.shadowOpacity = 0.1f;
    self.layer.cornerRadius = 8;
    [super setFrame:newFrame];
    
}

@end
