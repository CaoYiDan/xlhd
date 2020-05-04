//
//  YyhdViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/16.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "YyhdViewController.h"
#import "YyhdCell.h"
#import "HdjlViewController.h"
#import "HomeDianGuiModel.h"
#import "GhdcInfoModel.h"

@interface YyhdViewController ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic ,strong)NSArray *wxzDataArray;
@property (nonatomic ,strong)MAMapView *mapView;
@property (nonatomic ,strong)GhdcInfoModel *infoModel;

@end
static NSString *const cellId = @"cellId";
@implementation YyhdViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = self.titleStr;
    [self createTableView];
    self.tableView.top = ScreenWidth;
    self.tableView.height = self.tableView.height - ScreenWidth;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setupView];
    
    if ([self.titleStr isEqualToString:@"维修站"]) {
        [self requestWxzData];
    }else{
        [self requestGhdcData];
    }
}

- (void)setupView{
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
        self.navigationItem.rightBarButtonItem = rightBarItem;
    
    //地图需要v4.5.0及以上版本才必须要打开此选项（v4.5.0以下版本，需要手动配置info.plist）
       [AMapServices sharedServices].enableHTTPS = YES;
       
    //初始化地图
    self.mapView = [[MAMapView alloc] initWithFrame:self.bgView.bounds];
    self.mapView.delegate = self;
    //把地图添加至view
    [self.bgView addSubview:self.mapView];
    //隐藏比例尺
    _mapView.showsScale = NO;
    //隐藏高德左下角图标
    [_mapView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {

        if ([obj isKindOfClass:[UIImageView class]]) {

            UIImageView* logoM = obj;

            logoM.image= [UIImage new];

        }

    }];

    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YyhdCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)requestWxzData{
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@repair-station/select",base_url] param:nil success:^(NSDictionary *dict) {        
        if ([dict[@"errorCode"]intValue] == 0) {
            self.wxzDataArray = [NSArray yy_modelArrayWithClass:[HomeDianGuiModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
    }];
    
}

- (void)requestGhdcData{
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@battery/give-back",base_url] param:nil success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.infoModel = [GhdcInfoModel yy_modelWithJSON:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
    
    }];
}



- (void)rightBtn{
//    HdjlViewController *hdjlVC = [[HdjlViewController alloc]init];
//    [self.navigationController pushViewController:hdjlVC animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.titleStr isEqualToString:@"维修站"]) {
        return self.wxzDataArray.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YyhdCell *cell = [YyhdCell loadFromNIB];
    if (!cell) {
        cell = [[YyhdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    if ([self.titleStr isEqualToString:@"维修站"]) {
        [cell getWxzDataWithInfo:self.wxzDataArray[indexPath.row]];
    }else{
        [cell getGhdcDataWithInfo:self.infoModel];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
