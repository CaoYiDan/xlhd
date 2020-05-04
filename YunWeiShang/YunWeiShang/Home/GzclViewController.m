//
//  GzclViewController.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "GzclViewController.h"

@interface GzclViewController ()
{
    UITextView *textView;
}
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation GzclViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"故障处理";
    [self setupView];
}

- (void)setupView{
    [self.bgView setBorderLineWithColor:RGB(247, 247, 247)];
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.bgView.width, self.bgView.height)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.textColor = RGB(63, 63, 63);
    textView.font = [UIFont systemFontOfSize:15.f];
    [textView jk_addPlaceHolder:@"请输入故障描述"];
    // 限制 200个字符
    [textView setValue:@200 forKey:@"limit"];
    textView.jk_placeHolderTextView.textColor = RGB(207, 207, 209);
    [self.bgView addSubview:textView];
}



@end
