//
//  HomeViewController.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/21.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeListCell.h"
#import "TaskListViewController.h"
#import "SetViewController.h"
#import "HomeListModel.h"

@interface HomeViewController ()<UITableViewDelegate, UITableViewDataSource,UISearchBarDelegate,MAMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *mapBtn;

@property (weak, nonatomic) IBOutlet UIButton *shebeiBtn;
@property (weak, nonatomic) IBOutlet UIView *searView;
@property (weak, nonatomic) IBOutlet UIView *chooseView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (nonatomic ,strong)UIScrollView *scrollView;
@property (nonatomic ,strong)UIView *firstView;
@property (nonatomic ,strong)UIView *secondView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,strong)MAMapView *mapView;
@property (weak, nonatomic) IBOutlet UIButton *numberLab;
/** 定位view */
@property (nonatomic, strong) UIView *locationView;

@property(nonatomic,assign)NSInteger selectedIndex;

@end

static NSString *const cellId = @"cellId";

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    if (self.selectedIndex==0) {
        [self chooseBtnClick:self.shebeiBtn];
    }else{
        [self chooseBtnClick:self.mapBtn];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(238, 236, 234);
    self.selectedIndex = 0;
    [self setupView];
    [self requestData];
//    [self requestNumberData];
}

- (void)setupView{
    [self.chooseView setBorderLineWithColor:mainColor];
    
    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0,self.searView.width-40, 40)];
        //2.searchBar属性设置
    _searchBar.delegate = self;
        _searchBar.barStyle=UIBarStyleDefault;
        _searchBar.searchBarStyle=UISearchBarStyleMinimal;
        //_searchBar.prompt=@"prompt";
        _searchBar.placeholder=@"请输入站点名称或地址/充电柜编号搜索";
//        _searchBar.showsBookmarkButton=YES;
        _searchBar.showsCancelButton=NO;
        _searchBar.tintColor=[UIColor grayColor];
        _searchBar.barTintColor=[UIColor whiteColor];
        _searchBar.translucent=YES;
//    _searView.backgroundColor = [UIColor whiteColor];
//    UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
//
//    [searchField setValue:[UIColor whiteColor]forKeyPath:@"_placeholderLabel.textColor"];

        //输入框和输入文字的调整
        //白色的那个输入框的偏移
        _searchBar.searchFieldBackgroundPositionAdjustment=UIOffsetMake(5, 0);
        //输入的文字的位置偏移
        _searchBar.searchTextPositionAdjustment=UIOffsetMake(0, 0);
        //特定图片修改
//        [_searchBar setImage:[UIImage imageNamed:@"1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        [self.searView addSubview:_searchBar];
    
    self.scrollView = [ [UIScrollView alloc ] initWithFrame:self.bgView.bounds];
    self.scrollView.contentSize=CGSizeMake(ScreenWidth*2, self.bgView.height);//显示区域为图片的size，图片比手机屏幕大
        //self.scrollView.contentOffset=CGPointZero;//开始的原点，前两个属性可以实现基本的scrollView
    self.scrollView.contentOffset=CGPointMake(0, 0);//偏移量
    self.scrollView.contentInset=UIEdgeInsetsMake(0, 0, 0, 0);//self.scrollView.contentInset=UIEdgeInsetsMake(<#CGFloat top#>, <#CGFloat left#>, <#CGFloat bottom#>, <#CGFloat right#>)拉出后弹簧效果弹回后会有一个边框的存在，上左下右分别边框多大多少
    self.scrollView.bounces=NO;//默认是有弹簧效果的。设为NO后就不会有弹簧效果，拖动到可拖动的范围就不能 拖了。
    self.scrollView.contentSize = CGSizeMake(0,self.bgView.height);
    self.scrollView.showsHorizontalScrollIndicator=NO;//水平提示器，默认是有的
    self.scrollView.showsVerticalScrollIndicator=NO;//垂直提示器，默认是有的
    [self.bgView addSubview:self.scrollView];

    self.firstView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, self.bgView.height)];
    [self.scrollView addSubview:self.firstView];
    
    self.secondView = [[UIView alloc]initWithFrame:CGRectMake(ScreenWidth, 0, ScreenWidth, self.bgView.height)];
    [self.scrollView addSubview:self.secondView];
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight-70-64-20) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = RGB(236, 237, 238);
    [self.firstView addSubview:_tableView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([HomeListCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
    
    [AMapServices sharedServices].enableHTTPS = YES;
    self.mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, self.secondView.height - 49)];
    //    self.mapView = [[MAMapView alloc] initWithFrame:self.bgView.bounds];
    self.mapView.delegate = self;
    self.mapView.showsCompass = NO;
    //把地图添加至view
    [self.secondView addSubview:self.mapView];
    self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;

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

 
        [self addLocationBtn];
 }

//增加定位按钮
-(void)addLocationBtn{
    
    UIView *baseView = [[UIView alloc]init];
    baseView.layer.cornerRadius = 6;
    baseView.clipsToBounds = YES;
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    baseView.userInteractionEnabled = YES;
    self.locationView = baseView;
    [baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.offset(60);
        make.bottom.offset(-49-44);
        make.right.offset(-12);
    }];
    
    UIImageView *img = [[UIImageView alloc]init];
    img.image = [UIImage imageNamed:@"定位"];
    [baseView addSubview:img];
    img.userInteractionEnabled = YES;
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(-8);
        make.height.width.offset(30);
        make.centerX.offset(0);
    }];
    
    UILabel *textlabel = [[UILabel alloc]init];
    textlabel.text = @"定位";
    textlabel.textAlignment = NSTextAlignmentCenter;
    textlabel.textColor = [UIColor grayColor];
    textlabel.font = [UIFont systemFontOfSize:13];
    [baseView addSubview:textlabel];
    textlabel.userInteractionEnabled = YES;
    [textlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.offset(0);
        make.height.offset(20);
        make.top.equalTo(img.mas_bottom).offset(0);
    }];
    
    UIButton *tapBtn = [[UIButton alloc]init];
    [tapBtn addTarget:self action:@selector(location) forControlEvents:UIControlEventTouchUpInside];
    [baseView addSubview:tapBtn];
    [tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.offset(0);
    }];
    
}

//重新定位
-(void)location{
    self.mapView.centerCoordinate = self.mapView.userLocation.location.coordinate;
}

- (void)requestNumberData{
    
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@cabinet/number",base_url] param:nil success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        if ([dict[@"errorCode"]intValue] == 0) {
            [self.numberLab setTitle:[NSString stringWithFormat:@"  您共负责 %@ 个柜子，当前有 %@ 个柜子故障",dict[@"data"][@"number"],dict[@"data"][@"fault_number"]] forState:UIControlStateNormal];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestData{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"30" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
    [param setValue:@"1" forKey:@"status"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@cabinet/list",base_url] param:jsonStr success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[HomeListModel class] json:dict[@"data"]];
            [self DatasinMap];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

-(void)DatasinMap{//处理附近小区/停车场数据坐标

    NSMutableArray *xiaoquArr = [NSMutableArray array];

    /**  后台数据 **/

    for(HomeListModel *model in self.dataArray){

        MAPointAnnotation *pointAnimate = [[MAPointAnnotation alloc]init];//创建大头针  循环创建

         pointAnimate.coordinate = CLLocationCoordinate2DMake([model.lat floatValue],[model.lng floatValue]);

        pointAnimate.title = @"1";//把ID传给pointAnimate的title  进行判断是哪个大头针  这个比较重要
        [xiaoquArr addObject:pointAnimate];//把大头针装到一个数组
    }
        [self.mapView addAnnotations:xiaoquArr];//再将数组给到mapview

}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *reuseIndetifier = @"annotationReuseIndetifier";
        MAAnnotationView *annotationView = (MAAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
reuseIdentifier:reuseIndetifier];
        }
        annotationView.image = [UIImage imageNamed:@"dtzImg"];
        
        
        UILabel *lable=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, annotationView.width, annotationView.height)];
        lable.font=[UIFont systemFontOfSize:17];
        lable.textColor=[UIColor whiteColor];
        lable.textAlignment = NSTextAlignmentCenter;

        if (![annotation.title isEqualToString:@"当前位置"]) {
            annotationView.image = [UIImage imageNamed:@"dtzImg"];
            
        }else{
            annotationView.image = [UIImage imageNamed:@"location-4"];
            
        }
//        lable.text = @"3";
//        NSArray *titleArray=[NSArray arrayWithObjects:@"电柜",@"电柜", nil];
//        for (int a=0;a<titleArray.count;a++) {
////        lable.text=titleArray[a];
//        lable.text=@"电柜";
//        NSLog(@"a is %d",a);
//        NSLog(@"text is %@",lable.text);
//        }
        [annotationView addSubview:lable];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, 0, annotationView.width, annotationView.height);
//        [button addTarget:self action:@selector(dtzBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = [annotation.title integerValue];
        [annotationView addSubview:button];

        //设置中心点偏移，使得标注底部中间点成为经纬度对应点
//        annotationView.centerOffset = CGPointMake(0, -18);
        return annotationView;
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    HomeListCell *cell = [HomeListCell loadFromNIB];
    if (!cell) {
        cell = [[HomeListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 210+(ScreenWidth-40)/2;
}

- (IBAction)chooseBtnClick:(UIButton *)sender {
    for (UIButton *btn in self.buttons) {
        if (sender == btn) {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [btn setBackgroundColor:mainColor];
        }else{
            [btn setTitleColor:mainColor forState:UIControlStateNormal];
            [btn setBackgroundColor:[UIColor whiteColor]];
        }
    }
    if (sender.tag == 100) {
        self.scrollView.contentOffset=CGPointMake(0, 0);//偏移量
        self.locationView.hidden = YES;
        self.selectedIndex = 0;
    }else    {
        self.locationView.hidden = NO;
        self.selectedIndex = 1;
        self.scrollView.contentOffset=CGPointMake(ScreenWidth, 0);//偏移量
    }
}

- (IBAction)leftBtnClick:(UIButton *)sender {
    SetViewController *setVC = [[SetViewController alloc]init];
    [self.navigationController pushViewController:setVC animated:YES];
}

- (IBAction)rightBtnClick:(UIButton *)sender {
    TaskListViewController *taskListVC = [[TaskListViewController alloc]init];
    [self.navigationController pushViewController:taskListVC animated:YES];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
//    [self requestData:searchBar.text];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
   NSLog(@"%@",searchBar.text);
    if ([searchBar.text isEqualToString:@""]) {
//        [self requestData:@""];
    }
}


- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, 1.0f, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
}

@end
