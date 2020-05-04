//
//  GzbxViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/12/23.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "GzbxViewController.h"

@interface GzbxViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate,CLLocationManagerDelegate>
{
    UIImage *headImg;
}

@property (weak, nonatomic) IBOutlet UITextView *gzmsTV;
@property (weak, nonatomic) IBOutlet UITextField *dqwzTF;
@property (weak, nonatomic) IBOutlet UIButton *photoBtn;
@property (nonatomic,strong ) CLLocationManager *locationManager;

@end

@implementation GzbxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"报故障";
    [self setupView];
}

- (void)setupView{
    [self.gzmsTV setBorderLineWithColor:RGB(227, 228, 228)];
    self.dqwzTF.text = [NSString stringWithFormat:@"%@%@%@%@",user_province,user_locationCity,user_subLocality,user_street];
}

- (IBAction)submitBtnClick:(UIButton *)sender {
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:self.dqwzTF.text forKey:@"title"];
    [param setValue:self.gzmsTV.text forKey:@"describe"];
    [param setValue:@"" forKey:@"images"];
    [param setValue:@"000000" forKey:@"area_code"];
    [param setValue:user_latitude forKey:@"lat"];
    [param setValue:user_longitude forKey:@"lng"];
        NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
        [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@ticket/add",base_url] param:jsonStr success:^(NSDictionary *dict) {            
            if ([dict[@"errorCode"]intValue] == 0) {
                [self.navigationController popViewControllerAnimated:YES];
            }else{
                [self showHint:dict[@"message"]];
            }
        } fail:^(NSError *error) {
    //         NSLog(@"%@",error);
        }];
}

- (IBAction)uploadPhotoBtnClick:(UIButton *)sender {
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
        [self.photoBtn setImage:self->headImg forState:UIControlStateNormal];
        NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
            [param setValue:self->headImg forKey:@"UploadService[image_file]"];
            [[DataRequest Manager]SendUrl:[NSString stringWithFormat:@"%@file/upload",base_url] SendData:param Completion:^(id responseObject) {
                if ([responseObject[@"status"] integerValue] == 1) {
                    [self showHint:responseObject[@"message"]];

//                    [[NSUserDefaults standardUserDefaults] setObject:self.headImgUrl forKey:@"head_pic"];
//                    [[NSUserDefaults standardUserDefaults] synchronize];
                }else{
                    [self showHint:responseObject[@"message"]];
                }
            }];
       
            
        
        //拿到图片之后的操作
    }];
}
- (IBAction)updateLocationBtnClick:(UIButton *)sender {
    [self locatemap];
}

- (void)locatemap{
    
    if ([CLLocationManager locationServicesEnabled]) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        [_locationManager requestAlwaysAuthorization];
        [_locationManager requestWhenInUseAuthorization];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = 5.0;
//        _locationManager.locationTimeout =10;
//        _locationManager.reGeocodeTimeout = 10;
        [_locationManager startUpdatingLocation];
    }
}
#pragma mark - 定位成功
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{

    [_locationManager stopUpdatingLocation];
    CLLocation *currentLocation = [locations lastObject];
    //当前的经纬度
    NSLog(@"当前的经纬度 %f,%f",currentLocation.coordinate.latitude,currentLocation.coordinate.longitude);
    [[NSUserDefaults standardUserDefaults] setDouble:currentLocation.coordinate.latitude forKey:@"latitude"];
    [[NSUserDefaults standardUserDefaults] setDouble:currentLocation.coordinate.longitude forKey:@"longitude"];

//这里的代码是为了判断didUpdateLocations调用了几次 有可能会出现多次调用 为了避免不必要的麻烦 在这里加个if判断 如果大于1.0就return
    NSTimeInterval locationAge = -[currentLocation.timestamp timeIntervalSinceNow];
    if (locationAge > 1.0){//如果调用已经一次，不再执行
        return;
    }
    CLGeocoder *clGeoCoder = [[CLGeocoder alloc] init];
    [clGeoCoder reverseGeocodeLocation:currentLocation completionHandler: ^(NSArray *placemarks,NSError *error) {
        for (CLPlacemark *placeMark in placemarks)
        {
            
            NSDictionary *addressDic=placeMark.addressDictionary;//地址的所有信息

            NSString *state=[addressDic objectForKey:@"State"];//省。直辖市  江西省
            NSString *city=[addressDic objectForKey:@"City"];//市  丰城市
            NSString *subLocality=[addressDic objectForKey:@"SubLocality"];//区
            NSString *street=[addressDic objectForKey:@"Street"];//街道
            NSLog(@"=====%@",state);
            self.dqwzTF.text = [NSString stringWithFormat:@"%@%@%@%@",state,city,subLocality,street];
        }
        
    }];

}


@end
