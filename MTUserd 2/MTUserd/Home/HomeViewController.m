//
//  HomeViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/11.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "HomeViewController.h"
#import "UserInfoViewController.h"
#import "MessageViewController.h"
#import "YyhdViewController.h"
#import "GzbxViewController.h"
#import "HomeTopupViewController.h"
#import "FYLPageViewController.h"
#import "TestViewController.h"
#import "HomeDianGuiModel.h"
#import "YjczViewController.h"
#import "CustomAnnotationView.h"
#import "HomeListView.h"
#import "CommitMaintainVC.h"
#import "SWQRCode.h"
#import "MySelfAnnotationView.h"
#import <AVFoundation/AVFoundation.h>
@interface HomeViewController ()<MAMapViewDelegate>

@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *setBtn;
@property (weak, nonatomic) IBOutlet UIButton *timeBtn;
@property (weak, nonatomic) IBOutlet UIButton *sBtn;
@property (weak, nonatomic) IBOutlet UIButton *wBtn;
@property (weak, nonatomic) IBOutlet UIButton *lBtn;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *dlLab;
@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,strong)MAMapView *mapView;
@property(nonatomic,strong)NSMutableArray *viewControllers;
@property (nonatomic ,strong)HomeListView *listView;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;


@property (weak, nonatomic) IBOutlet UIView *orderChangeBatteryView;

@property (weak, nonatomic) IBOutlet UIView *batteryBackView;
@end

@implementation HomeViewController

- (NSMutableArray *)viewControllers {
    if (!_viewControllers) {
        _viewControllers = [NSMutableArray array];
        
        for (int i = 1; i <= 6; i++) {
            TestViewController *vc = [[TestViewController alloc] init];
            vc.index = i;
            [_viewControllers addObject:vc];
        }
    }
    return _viewControllers;
}

//获取电量
- (void)requestdlData{
    
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@battery/my-battery",base_url] param:nil success:^(NSDictionary *dict) {
        NSInteger i = [dict[@"data"][@"battery_percentage"]intValue];
        self.dlLab.text = [NSString stringWithFormat:@"%ld%%",(long)i];
    } fail:^(NSError *error) {
        
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",Token);
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"xlhd.mp3" withExtension:nil];
        // 2. 创建音乐播放对象
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
        // 3.准备播放 (音乐播放的内存空间的开辟等功能)  不写这行代码直接播放也会默认调用prepareToPlay
    [self.audioPlayer prepareToPlay];
    [self requestdlData];
    __weak __typeof(&*self)weakSelf = self;
    dispatch_time_t delayTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0/*延迟执行时间*/ * NSEC_PER_SEC));
//
    dispatch_after(delayTime, dispatch_get_main_queue(), ^{
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT,0), ^{
           while (TRUE) {
               // 每隔5秒执行一次（当前线程阻塞5秒）
//               [NSThread sleepForTimeInterval:60];

//               [weakSelf requestdlData];
           };
       });
//
    self.view.backgroundColor = RGB(236, 237, 238);
    self.title = @"小鹿换电";
    [self setupView];
    [self requestData];
    
}

- (void)setupView{
    //地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
    [AMapServices sharedServices].enableHTTPS = YES;
    
    //初始化地图
    
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, self.bgView.width, self.bgView.height)];
//    self.mapView = [[MAMapView alloc] initWithFrame:self.bgView.bounds];
    self.mapView.delegate = self;
    self.mapView.showsCompass = NO;
    //把地图添加至view
    [self.bgView addSubview:self.mapView];
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
//隐藏高德左下角图标
//    for (UIView *view in _mapView.subviews) {
//        if ([view isKindOfClass:[UIImageView class]]) {
//            [view removeFromSuperview];
//        }
//    }
    
    _mapView.zoomLevel = 15;
    //隐藏比例尺
    _mapView.showsScale = NO;
    //隐藏高德左下角图标
    [_mapView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if ([obj isKindOfClass:[UIImageView class]]) {

            UIImageView* logoM = obj;

            logoM.image= [UIImage new];

        }

    }];

    
    
    UIView *baseView = [[UIView alloc]init];
    baseView.layer.cornerRadius = 6;
    baseView.clipsToBounds = YES;
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    baseView.userInteractionEnabled = YES;
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(self.batteryBackView);
        make.bottom.equalTo(self.orderChangeBatteryView.mas_top).offset(-10);
    }];
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"图层 14 拷贝"];
    [baseView addSubview:img];
    img.userInteractionEnabled = YES;
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-10);
        make.height.width.offset(35);
        make.centerX.offset(0);
    }];
    
    UILabel *textlabel = [[UILabel alloc]init];
    textlabel.text = @"维修站";
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.textColor = [UIColor lightGrayColor];
    textlabel.font = [UIFont systemFontOfSize:13];
    [baseView addSubview:textlabel];
    textlabel.userInteractionEnabled = YES;
    [textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(20);
        make.top.equalTo(img.mas_bottom).offset(0);
    }];
    
    UIButton *tapBtn = [[UIButton alloc]init];
    [tapBtn addTarget:self action:@selector(maintain) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:tapBtn];
    [tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
    {
        UIView *baseView = [[UIView alloc]init];
        baseView.layer.cornerRadius = 6;
        baseView.clipsToBounds = YES;
        baseView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:baseView];
        [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.height.equalTo(self.batteryBackView);
            make.bottom.equalTo(self.batteryBackView.mas_top).offset(-10);
        }];
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"图层 12"];
        [baseView addSubview:img];
        [img mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.offset(-10);
            make.height.width.offset(35);
            make.centerX.offset(0);
        }];
        
        UILabel *textlabel = [[UILabel alloc]init];
        textlabel.text = @"故障报修";
        textlabel.textAlignment = NSTextAlignmentCenter;
        textlabel.textColor = [UIColor lightGrayColor];
        textlabel.font = [UIFont systemFontOfSize:13];
        [baseView addSubview:textlabel];
        [textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.offset(0);
            make.height.offset(20);
            make.top.equalTo(img.mas_bottom).offset(0);
        }];
        
        UIButton *tapBtn = [[UIButton alloc]init];
           [tapBtn addTarget:self action:@selector(commitMaintain) forControlEvents:UIControlEventTouchUpInside];
           [baseView addSubview:tapBtn];
           [tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
               make.edges.offset(0);
           }];
    }

    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
    self.navigationItem.rightBarButtonItem = rightBarItem;
    UIBarButtonItem *leftBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"我的"] style:UIBarButtonItemStylePlain target:self action:@selector(leftBtn)];
    self.navigationItem.leftBarButtonItem = leftBarItem;
    
    self.listView = [HomeListView loadFromNIB];
    if (@available(iOS 11.0, *)) {
        CGFloat a =  [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
    //        NSLog(@"======11   %f",a);
        if (a > 0) {
            self.listView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-44-20);
        }else{
            self.listView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-44-20);
        }
    } else {
        self.listView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-44-20);
    }
    [self.view addSubview:self.listView];
    self.listView.hidden = YES;
   
    UITapGestureRecognizer *sntapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureClick)];
    [self.listView addGestureRecognizer:sntapGesture];
    
     NSMutableArray *xiaoquArr = [NSMutableArray array];

    
    
//   MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc]init];
//    pointAnnotation.coordinate = CLLocationCoordinate2DMake(39.989631, 116.481018);
//    pointAnnotation.title = @"小A";
//    pointAnnotation.subtitle = @"假的";
//
//  MAPointAnnotation *pointAnnotation1 = [[MAPointAnnotation alloc]init];
//  pointAnnotation1.coordinate = CLLocationCoordinate2DMake(40.389631, 116.481018);
//
//            pointAnnotation1.title = @"小B";
//
//            pointAnnotation1.subtitle = @"真的";
//
//
//
//            MAPointAnnotation *pointAnnotation2 = [[MAPointAnnotation alloc]init];
//
//            pointAnnotation2.coordinate = CLLocationCoordinate2DMake(36.989631, 116.481018);
//
//            pointAnnotation2.title = @"小C";
//
//            pointAnnotation2.subtitle = @"哈哈";
//            //添加给mapView
//
//            [_mapView addAnnotations:@[pointAnnotation, pointAnnotation1,pointAnnotation2]];
}

//故障报修点击事件
-(void)commitMaintain{
    Toast(@"开发中...");
    return;
    CommitMaintainVC *vc = [[CommitMaintainVC alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}
//维修站点击事件
-(void)maintain{
    Toast(@"开发中...");
}

- (void)tapGestureClick{
    if (@available(iOS 11.0, *)) {
        CGFloat a =  [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
    //        NSLog(@"======11   %f",a);
        if (a > 0) {
            self.listView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight-44-20);
        }else{
            self.listView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight-44-20);
        }
    } else {
        self.listView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight-44-20);
    }
}
       

-(void)DatasinMap{//处理附近小区/停车场数据坐标

    NSMutableArray *xiaoquArr = [NSMutableArray array];

    /**  后台数据 **/

    for(HomeDianGuiModel *model in self.dataArray){

        MAPointAnnotation *pointAnimate = [[MAPointAnnotation alloc]init];//创建大头针  循环创建

         pointAnimate.coordinate = CLLocationCoordinate2DMake([model.lat floatValue],[model.lng floatValue]);

        pointAnimate.title = model.batteries;//把ID传给pointAnimate的title  进行判断是哪个大头针  这个比较重要
        [xiaoquArr addObject:pointAnimate];//把大头针装到一个数组
    }
        [self.mapView addAnnotations:xiaoquArr];//再将数组给到mapview

}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier2";
        MySelfAnnotationView *annotationView = [[MySelfAnnotationView alloc] initWithAnnotation:annotation
                       reuseIdentifier:reuseIndetifier];
        annotationView.selected = NO;
        MAPointAnnotation *pointAnnotation = (MAPointAnnotation *)annotation;
        [annotationView setBatteriesNum:pointAnnotation.title];
        return annotationView;
    }
    return nil;
}

- (void)dtzBtnClick:(UIButton *)btn{
    [self startGaodeMap];
}

-(void) startGaodeMap
{
    CLLocationCoordinate2D myLocation = CLLocationCoordinate2DMake(29.569389,106.557978);
    CLLocationCoordinate2D storeLoacation = CLLocationCoordinate2DMake(29.615133,106.605053);
    myLocation = AMapCoordinateConvert(myLocation,AMapCoordinateTypeGPS);;
    storeLoacation =AMapCoordinateConvert(storeLoacation,AMapCoordinateTypeGPS);;
    
    NSString *urlString = [[NSString stringWithFormat:@"iosamap://path?sourceApplication=%@&sid=BGVIS1&slat=%f&slon=%f&sname=%@&did=BGVIS2&dlat=%f&dlon=%f&dname=%@&dev=0&m=0&t=0",@"", myLocation.latitude, myLocation.longitude,@"我的位置", storeLoacation.latitude, storeLoacation.longitude, @"北京"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:urlString]];
}


// 百度地图经纬度转换为高德地图经纬度
- (CLLocationCoordinate2D)getGaoDeCoordinateByBaiDuCoordinate:(CLLocationCoordinate2D)coordinate   {
    return CLLocationCoordinate2DMake(coordinate.latitude - 0.006, coordinate.longitude - 0.0065);
}

- (void)requestData{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:user_latitude forKey:@"lat"];
    [param setValue:user_longitude forKey:@"lng"];
    [param setValue:@1000000 forKey:@"range"];
    NSLog(@"%@",param);
    
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@charging-cabinet/pick-by-coordinates",base_url] param:jsonStr success:^(NSDictionary *dict) {
        
        NSLog(@"%@",dict);
        
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[HomeDianGuiModel class] json:dict[@"data"]];
            [self DatasinMap];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
//         NSLog(@"%@",error);
    }];
    
}



- (void)rightBtn{
    MessageViewController *messageVC = [[MessageViewController alloc]init];
    [self.navigationController pushViewController:messageVC animated:YES];
}

- (void)leftBtn{
    UserInfoViewController *userInfo = [[UserInfoViewController alloc]init];
    [self.navigationController pushViewController:userInfo animated:YES];
}

//点击联系商家
- (IBAction)connectShop:(id)sender {
    
    //获取商家联系电话
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@user/get-bind-merchant",base_url] param:nil success:^(NSDictionary *dict) {
          if ([dict[@"errorCode"]intValue] == 0) {
              
              
              NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",dict
                                    [@"data"][@"merchant_phone"]];

                 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
              
          }else{
              
              [self showHint:dict[@"message"]];
              
          }
      } fail:^(NSError *error) {
           NSLog(@"%@",error);
      }];
   

}

- (IBAction)homeBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100:{
            
            
           [self.audioPlayer play];
            
//            NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"tel:%@",@"1008611"];
//            UIWebView * callWebview = [[UIWebView alloc] init];
//            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
//            [self.view addSubview:callWebview];
        }
            break;
        case 200:{
                [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@battery/give-back",base_url] param:nil success:^(NSDictionary *dict) {
                        [self showHint:dict[@"message"]];
                } fail:^(NSError *error) {
            //         NSLog(@"%@",error);
                }];
            
//            YyhdViewController *yyhdVC = [[YyhdViewController alloc]init];
//            yyhdVC.titleStr = @"归还电池";
//            [self.navigationController pushViewController:yyhdVC animated:YES];
        }
            break;
        case 300:{
            GzbxViewController *gzbxVC = [[GzbxViewController alloc]init];
            [self.navigationController pushViewController:gzbxVC animated:YES];
        }
            break;
        case 400:{
             FYLPageViewController *vc = [[FYLPageViewController alloc] initWithTitles:@[@"金币",@"月卡",@"购买电池",@"次数卡",@"押金"] viewControllers:self.viewControllers];
            [self.navigationController pushViewController:vc animated:YES];
        }
            break;
        case 500:{
            if (@available(iOS 11.0, *)) {
                CGFloat a =  [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom;
            //        NSLog(@"======11   %f",a);
                if (a > 0) {
                    self.listView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-44-20);
                }else{
                    self.listView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-44-20);
                }
            } else {
                self.listView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight-44-20);
            }
        }
            break;
        case 600:{
            YyhdViewController *yyhdVC = [[YyhdViewController alloc]init];
            yyhdVC.titleStr = @"维修站";
            [self.navigationController pushViewController:yyhdVC animated:YES];
        }
            break;
        case 700:{
            self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
        }
            break;
        default:
            break;
    }
}


- (IBAction)saoyisaoBtnClick:(UIButton *)sender {
    SWQRCodeConfig *config = [[SWQRCodeConfig alloc]init];
    config.scannerType = SWScannerTypeBoth;
    
    SWQRCodeViewController *qrcodeVC = [[SWQRCodeViewController alloc]init];
    qrcodeVC.codeConfig = config;
    [self.navigationController pushViewController:qrcodeVC animated:YES];
   
}


@end
