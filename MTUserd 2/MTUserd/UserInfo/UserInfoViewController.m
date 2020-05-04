//
//  UserInfoViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/11.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "UserInfoViewController.h"
#import "SetViewController.h"
#import "MessageViewController.h"
#import "WalletViewController.h"
#import "MyBreakdownViewController.h"
#import "MyEwmViewController.h"
#import "MyBatteryViewController.h"
#import "MyDistributionViewController.h"
#import "OrderViewController.h"
#import "BatteryModel.h"

@interface UserInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UIImage *headImg;
}

@property (weak, nonatomic) IBOutlet UIImageView *headPhoto;
@property (nonatomic ,strong)BatteryModel *model;
@property (weak, nonatomic) IBOutlet UIButton *myOrderBtn;
@property (weak, nonatomic) IBOutlet UIButton *myBatteryBtn;

@end

@implementation UserInfoViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestData];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人中心";
    [self setupView];

}

- (void)setupView{
//    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@""] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
//    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    UIButton *informationCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [informationCardBtn addTarget:self action:@selector(rightBtn) forControlEvents:UIControlEventTouchUpInside];
    [informationCardBtn setImage:[UIImage imageNamed:@"设置 拷贝"] forState:UIControlStateNormal];
    
    [informationCardBtn sizeToFit];
    UIBarButtonItem *informationCardItem = [[UIBarButtonItem alloc] initWithCustomView:informationCardBtn];
    
    
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 22;
    
    
    UIButton *settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [settingBtn addTarget:self action:@selector(leftBtn) forControlEvents:UIControlEventTouchUpInside];
    [settingBtn setImage:[UIImage imageNamed:@"消息"] forState:UIControlStateNormal];
    [settingBtn sizeToFit];
    UIBarButtonItem *settingBtnItem = [[UIBarButtonItem alloc] initWithCustomView:settingBtn];
    self.navigationItem.rightBarButtonItems  = @[informationCardItem,fixedSpaceBarButtonItem,settingBtnItem];
    
    
    UIButton *removeBindBtn = [[UIButton alloc]init];
    [removeBindBtn setTitleColor:[UIColor blackColor] forState:0];
    removeBindBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [removeBindBtn setTitle:@"  解绑商家" forState:0];
    [self.view addSubview:removeBindBtn];
    [removeBindBtn addTarget:self action:@selector(removeBindClick) forControlEvents:UIControlEventTouchUpInside];
    [removeBindBtn setImage:[UIImage imageNamed:@"解绑(1) 拷贝"] forState:0];
    [removeBindBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.myBatteryBtn).offset(-10);
        make.centerY.equalTo(self.myOrderBtn);
        make.width.equalTo(self.myBatteryBtn);
        make.height.equalTo(self.myOrderBtn);
    }];
}

//解绑点击
-(void)removeBindClick{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"确认解除？"
                                                                      message:@""
                                                               preferredStyle:UIAlertControllerStyleAlert];
       
       UIAlertAction* defaultAction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
           [self merchantunbind];
                                                             }];
       UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                                                 //响应事件
                                                                 NSLog(@"action = %@", action);
                                                             }];

       [alert addAction:defaultAction];
       [alert addAction:cancelAction];
       [self presentViewController:alert animated:YES completion:nil];
}

//解绑请求
-(void)merchantunbind{
   

   [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@user/merchant-unbind",base_url] param:nil success:^(NSDictionary *dict) {
       if ([dict[@"errorCode"]intValue] == 0) {
           Toast(dict[@"message"])
       }else{
           [self showHint:dict[@"message"]];
       }
   } fail:^(NSError *error) {
        NSLog(@"%@",error);
   }];
}

- (void)requestData{
    
//    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//    [param setValue:self.phoneTF.text forKey:@"phonenumber"];
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@battery/my-battery",base_url] param:nil success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.model = [BatteryModel yy_modelWithJSON:dict[@"data"]];
            [self setupView];
        }else{
//            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
         NSLog(@"%@",error);
    }];
}

- (void)rightBtn{
    SetViewController *setVC = [[SetViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (void)leftBtn{
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (IBAction)userInfoBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100:{
            WalletViewController *walletVC = [[WalletViewController alloc]init];
            [self.navigationController pushViewController:walletVC animated:YES];
        }
            break;
        case 200:{
            if (self.model) {
                MyBatteryViewController *batteryVC = [[MyBatteryViewController alloc]init];
                batteryVC.model = self.model;
                [self.navigationController pushViewController:batteryVC animated:YES];
            }else{
                [self showHint:@"您还没有电池"];
            }
        }
            break;
        case 300:{
            MyEwmViewController *ewmVC = [[MyEwmViewController alloc]init];
            [self.navigationController pushViewController:ewmVC animated:YES];
        }
            break;
        case 400:{
            MyBreakdownViewController *breakdownVC = [[MyBreakdownViewController alloc]init];
            [self.navigationController pushViewController:breakdownVC animated:YES];
        }
            break;
        case 500:{
//            MyDistributionViewController *distributionVC = [[MyDistributionViewController alloc]init];
//            [self.navigationController pushViewController:distributionVC animated:YES];
            OrderViewController *orderVC = [[OrderViewController alloc]init];
            [self.navigationController pushViewController:orderVC animated:YES];
        }
            break;
        case 600:{
            [self showHint:@"敬请期待"];
        }
            break;
        case 700:{
            [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@user/merchant-un-bind",base_url] param:nil success:^(NSDictionary *dict) {
                if ([dict[@"errorCode"]intValue] == 0) {
                    [self showHint:dict[@"message"]];
                }else{
                    [self showHint:dict[@"message"]];
                }
            } fail:^(NSError *error) {
            }];
        }
            break;
            
        default:
            break;
    }
    
}

- (IBAction)headImgBtnClick:(UIButton *)sender {
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]){
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", @"拍照", nil];
        [sheet showInView:self.view];
    }else{
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择照片来源" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"相册", nil];
        [sheet showInView:self.view];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSInteger sourceType;
    
    // 判断是否支持相机
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        switch (buttonIndex) {
            case 0:
                //来源:相册
                sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                break;
            case 1:
                //来源:相机
                sourceType = UIImagePickerControllerSourceTypeCamera;
                break;
            default:
                return;
        }
    }else{
        if (buttonIndex == 0) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }else
            return;
    }
    
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = sourceType;
    [self presentViewController:imagePickerController animated:YES completion:^{
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    }];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
//    __weak typeof(self) weakSelf = self;
    [picker dismissViewControllerAnimated:YES completion:^{
        if (picker.allowsEditing){
            self->headImg = [info objectForKey:UIImagePickerControllerEditedImage];
        }else{
            self->headImg= [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        self.headPhoto.image = headImg;
//        [[DataRequest Manager]uploadPhoto:[NSString stringWithFormat:@"%@uploadPictures",base_url] Image:self->headImg radio:3 Completion:^(id responseObject) {
//            if (![responseObject isEqualToString:@"失败"]) {
//                self.myHeadImg.image = self->headImg;
//                self.headImgUrl = responseObject;
//                NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
//                [param setValue:Token forKey:@"token"];
//                [param setValue:responseObject forKey:@"head_pic"];
//                [[DataRequest Manager]SendUrl:[NSString stringWithFormat:@"%@upload",base_url] SendData:param Completion:^(id responseObject) {
//                    if ([responseObject[@"code"] integerValue] == 200) {
//                        [[NSUserDefaults standardUserDefaults] setObject:self.headImgUrl forKey:@"head_pic"];
//                        [[NSUserDefaults standardUserDefaults] synchronize];
//                    }else{
//                        [self showHint:responseObject[@"message"]];
//                    }
//                }];
//            }else{
//                [self showHint:@"上传失败"];
//            }
//        }];
        
        //拿到图片之后的操作
    }];
}



@end
