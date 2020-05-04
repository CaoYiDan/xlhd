//
//  XfkViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/12.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "XfkViewController.h"

@interface XfkViewController ()
{
    UITextView *textView;
}
@property (weak, nonatomic) IBOutlet UIView *fView;
@property (weak, nonatomic) IBOutlet UIView *sView;

@end

@implementation XfkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"意见反馈";
    [self setupView];
}

- (void)setupView{
    [self.fView setBorderLineWithColor:RGB(244, 245, 246)];
    [self.sView setBorderLineWithColor:RGB(244, 245, 246)];
    textView = [[UITextView alloc]initWithFrame:CGRectMake(0, 0, self.fView.width, self.fView.height)];
    textView.backgroundColor = [UIColor whiteColor];
    textView.textColor = RGB(63, 63, 63);
    textView.font = [UIFont systemFontOfSize:15.f];
    [textView jk_addPlaceHolder:@"请输入投诉内容"];
    // 限制 200个字符
    [textView setValue:@200 forKey:@"limit"];
    textView.jk_placeHolderTextView.textColor = RGB(207, 207, 209);
    [self.fView addSubview:textView];
}

- (IBAction)submitBtnClick:(UIButton *)sender {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
        [param setValue:@"123" forKey:@"title"];
        [param setValue:textView.text forKey:@"content"];
    
        [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@feedback/commit",base_url] param:param success:^(NSDictionary *dict) {
            if ([dict[@"errorCode"]intValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showHint:dict[@"message"]];
            }
        } fail:^(NSError *error) {
    //         NSLog(@"%@",error);
        }];
}

@end
