//
//  UserInfoViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2019/11/8.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "UserInfoViewController.h"
#import "YuEInfoViewController.h"
#import <Photos/Photos.h>
@interface UserInfoViewController ()<UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *headImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLab;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIImageView *ewmImg;
@property (weak, nonatomic) IBOutlet UILabel *yeLab;
@property (weak, nonatomic) IBOutlet UILabel *fcjeLab;

@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(236, 237, 238);
    self.title = @"个人中心";
    [self setupView];
    [self requestData];
    [self requestMoneyData];
}

- (void)setupView{
    [self.saveBtn setBorderLineWithColor:RGB(205, 210, 217)];
}

- (void)requestData{
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@merchant",base_url] param:nil success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        if ([dict[@"errorCode"]intValue] == 0) {
            [self.ewmImg sd_setImageWithURL:[NSURL URLWithString:dict[@"data"][@"qr_code"]] placeholderImage:[UIImage imageNamed:@""]];
            self.nameLab.text = dict[@"data"][@"name"];
//            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestMoneyData{
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@merchant/wallet",base_url] param:nil success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
//            self.model = [HomeTopModel yy_modelWithJSON:dict[@"data"]];
            self.yeLab.text = [NSString stringWithFormat:@"%@",dict[@"data"][@"balance"]];
            self.fcjeLab.text = [NSString stringWithFormat:@"%@",dict[@"data"][@"total"]];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (IBAction)userInfoBtnClick:(UIButton *)sender {
    if (sender.tag == 100) {
        UIImage *img = [UIImage imageNamed:@"ewm"];

        UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

    }else{
        SendMessageToWXReq *req = [[SendMessageToWXReq alloc]init];
        
        WXMediaMessage *message = [WXMediaMessage message];
        WXImageObject *imageObject = [[WXImageObject alloc]init];
        UIImage *image = [UIImage imageNamed:@"ewm"];
        NSDate *data = UIImageJPEGRepresentation(image, 1.0);
        imageObject.imageData = data;
        message.mediaObject = imageObject;
        req.bText = NO;
        req.message = message;
        req.scene = WXSceneSession;
        BOOL isInstalled = [WXApi sendReq:req];
        if (isInstalled == NO) {
            //失败：没有安装
        }
        
        
    }
}

- (IBAction)yeInfoBtnClick:(UIButton *)sender {
    YuEInfoViewController *yeInfoVC = [[YuEInfoViewController alloc]init];
    [self.navigationController pushViewController:yeInfoVC animated:YES];
}

#pragma mark -- <保存到相册>
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
}


- (NSData *)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContext(newSize);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return UIImageJPEGRepresentation(newImage, 0.8);
}

@end
