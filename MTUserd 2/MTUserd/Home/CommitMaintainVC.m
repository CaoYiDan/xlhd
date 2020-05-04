//
//  CommitMaintainVC.m
//  MTUserd
//
//  Created by MAC on 2020/4/30.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "CommitMaintainVC.h"

@interface CommitMaintainVC ()

@end

@implementation CommitMaintainVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"故障上报";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UILabel *textlabel = [[UILabel alloc]init];
    textlabel.text = @"当前位置";
    textlabel.textColor = [UIColor blackColor];
    textlabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:textlabel];
    [textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.height.offset(30);
        make.top.equalTo(self.view).offset(30);
    }];
    
    UILabel *loacationlabel = [[UILabel alloc]init];
      loacationlabel.text = self.currentLcation;
      loacationlabel.textColor = [UIColor blackColor];
      loacationlabel.font = [UIFont systemFontOfSize:14];
      [self.view addSubview:loacationlabel];
      [loacationlabel mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.equalTo(textlabel.mas_right).offset(12);
          make.height.offset(30);
          make.top.equalTo(self.view).offset(30);
      }];
    
    UILabel *describelabel = [[UILabel alloc]init];
    describelabel.text = @"故障描述";
    describelabel.textColor = [UIColor blackColor];
    describelabel.font = [UIFont systemFontOfSize:14];
    [self.view addSubview:describelabel];
    [describelabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(12);
        make.height.offset(30);
        make.top.equalTo(textlabel.mas_bottom).offset(100);
    }];
    
    UITextView *textView = [[UITextView alloc]init];
    textView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    textView.layer.borderWidth = 1.0f;
    [self.view addSubview:textView];
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(describelabel);
        make.left.equalTo(describelabel.mas_right).offset(12);
        make.right.offset(-12);
        make.height.offset(100);
    }];
    
    
    
    UIButton *commitBtn = [[UIButton alloc]init];
    commitBtn.backgroundColor = RGB(11, 130, 248);
    commitBtn.layer.cornerRadius = 20;
    commitBtn.clipsToBounds = YES;
    [commitBtn setTitle:@"提交" forState:0];
    [commitBtn addTarget:self action:@selector(commitClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:commitBtn];
    [commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.offset(180);
        make.bottom.offset(-40);
        make.height.offset(40);
    }];
}

//提交
-(void)commitClick{
    
}

@end
