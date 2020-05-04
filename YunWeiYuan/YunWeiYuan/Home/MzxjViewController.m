
//
//  MzxjViewController.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "MzxjViewController.h"

@interface MzxjViewController ()
{
    UITextView *textView;
}
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *addressLab;
@property (weak, nonatomic) IBOutlet UILabel *sbIdLab;
@property (weak, nonatomic) IBOutlet UIButton *stateBtn;
@property (weak, nonatomic) IBOutlet UIButton *submitBtn;

@end

@implementation MzxjViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.addBtn.hidden = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.titleStr;
    [self setupView];
}

- (void)setupView{
    if ([self.titleStr isEqualToString:@"提交故障"]) {
        [self.stateBtn setTitle:@"故障" forState:UIControlStateNormal];
        self.stateBtn.backgroundColor = RGB(140, 48, 35);
        [self.stateBtn setTitle:@"提交故障" forState:UIControlStateNormal];
    }
    self.nameLab.text = [NSString stringWithFormat:@"名称：%@",self.model.cabinet_name];
    self.sbIdLab.text = [NSString stringWithFormat:@"设备ID：%@",self.model.device_code];
    self.addressLab.text = [NSString stringWithFormat:@"地址：%@",self.model.address];
    
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

- (IBAction)stateBtnClick:(UIButton *)sender {
    if ([self.titleStr isEqualToString:@"每周巡检"]) {
        sender.selected = !sender.selected;
        if (sender.selected) {
            [sender setTitle:@"故障" forState:UIControlStateNormal];
            sender.backgroundColor = RGB(140, 48, 35);
        }else{
            [sender setTitle:@"正常" forState:UIControlStateNormal];
            sender.backgroundColor = mainColor;
        }
    }
}

- (IBAction)submitBtnClick:(UIButton *)sender {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.model.device_code forKey:@"device_code"];
    [param setValue:textView.text forKey:@"describe"];
    if ([self.stateBtn.titleLabel.text isEqualToString:@"正常"]) {
        [param setValue:@"1" forKey:@"status"];
    }else{
        [param setValue:@"0" forKey:@"status"];
    }
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@check/submit",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            [self.navigationController popViewControllerAnimated:YES];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}


@end
