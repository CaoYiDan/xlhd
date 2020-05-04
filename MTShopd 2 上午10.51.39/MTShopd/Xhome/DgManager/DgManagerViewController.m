//
//  DgManagerViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2020/3/18.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "DgManagerViewController.h"
#import "DgManegerListCell.h"
#import "DgManagerModel.h"
#import "DgManagerDetailView.h"

@interface DgManagerViewController ()<UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UILabel *fnumLab;
@property (weak, nonatomic) IBOutlet UILabel *flab;
@property (weak, nonatomic) IBOutlet UILabel *snumLab;
@property (weak, nonatomic) IBOutlet UILabel *slab;
@property (weak, nonatomic) IBOutlet UILabel *tnumLab;
@property (weak, nonatomic) IBOutlet UILabel *tlab;
@property (weak, nonatomic) IBOutlet UILabel *numLab;
@property (weak, nonatomic) IBOutlet UIView *searchView;
@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,strong)NSArray *dlDataArray;
@property (nonatomic ,strong)DgManagerDetailView *detailView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, assign)NSInteger index;

@end
static NSString *const cellId = @"dgManegerListCell";
@implementation DgManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = RGB(236, 237, 238);
    self.index = 100;
    self.title = @"电柜管理";
    //[self createTableView];
    self.tableView.top = 190-45;
    self.tableView.height = self.tableView.height - 190+45;
    [self setupView];
    [self requestData];
    [self requestNumData];
    [self requestZxNumData];
    [self requestLxNumData];
}

- (void)setupView{
    self.detailView = [DgManagerDetailView loadFromNIB];
    self.detailView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
    [self.detailView.closeBtn addTarget:self action:@selector(sntapGestureClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.detailView];
    UITapGestureRecognizer *sntapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sntapGestureClick)];
    [self.detailView addGestureRecognizer:sntapGesture];

//    _searchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 2.5,self.searchView.width-50, 30)];
//        //2.searchBar属性设置
//    _searchBar.backgroundColor = [UIColor whiteColor];
//    _searchBar.delegate = self;
//        _searchBar.barStyle=UIBarStyleBlack;
//        _searchBar.searchBarStyle=UISearchBarStyleMinimal;
//        //_searchBar.prompt=@"prompt";
//        _searchBar.placeholder=@"电柜名称/地址搜索";
////        _searchBar.showsBookmarkButton=YES;
//        _searchBar.showsCancelButton=NO;
//        _searchBar.tintColor=[UIColor whiteColor];
//        _searchBar.barTintColor=[UIColor whiteColor];
//        _searchBar.translucent=YES;
//    _searView.backgroundColor = [UIColor whiteColor];
//    UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
//
//    [searchField setValue:[UIColor whiteColor]forKeyPath:@"_placeholderLabel.textColor"];

        //输入框和输入文字的调整
        //白色的那个输入框的偏移
//        _searchBar.searchFieldBackgroundPositionAdjustment=UIOffsetMake(5, 0);
//        //输入的文字的位置偏移
//        _searchBar.searchTextPositionAdjustment=UIOffsetMake(0, 0);
//        //特定图片修改
////        [_searchBar setImage:[UIImage imageNamed:@"1"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//        [self.searchView addSubview:_searchBar];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DgManegerListCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)requestNumData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];

     NSMutableDictionary *jsonStr = param;

    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@cabinet/number",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.numLab.text = [NSString stringWithFormat:@"%@",dict[@"data"][@"number"]];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//在线
- (void)requestZxNumData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@[@"1",@"2"] forKey:@"statuses"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@cabinet/number",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.fnumLab.text = [NSString stringWithFormat:@"%@个",dict[@"data"][@"number"]];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}
//离线
- (void)requestLxNumData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@[@"0",@"4"] forKey:@"statuses"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@cabinet/number",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.snumLab.text = [NSString stringWithFormat:@"%@个",dict[@"data"][@"number"]];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    if (self.index == 100) {
        [param setValue:@[@"1",@"2"] forKey:@"statuses"];
    }else if (self.index == 200){
        [param setValue:@[@"0",@"4"] forKey:@"statuses"];
    }
    [param setValue:@"10" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
     NSMutableDictionary *jsonStr = param;
    NSLog(@"%@  %@",jsonStr,Token);
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@cabinet",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[DgManagerModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)sntapGestureClick{
    self.detailView.frame = CGRectMake(0, ScreenHeight, ScreenWidth, ScreenHeight);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DgManegerListCell *cell = [DgManegerListCell loadFromNIB];
    if (!cell) {
        cell = [[DgManegerListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.detailView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"1" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@cabinet/electricity",base_url] param:jsonStr success:^(NSDictionary *dict) {
        NSLog(@"%@",dict);
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dlDataArray = [NSArray yy_modelArrayWithClass:[DgManagerModel class] json:dict[@"data"]];
           
            if (self.dlDataArray.count==0) {
                           return ;
                       }
            
            [self.tableView reloadData];
            self.detailView.bhLab.text = [NSString stringWithFormat:@"编号：%@ 电柜月度电表",dict[@"data"][0][@"device_code"]];
            self.detailView.titleLab.text = [NSString stringWithFormat:@"%@-%@       %@KWH",dict[@"data"][0][@"year"],dict[@"data"][0][@"month"],dict[@"data"][0][@"kwh"]];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark - SearchViewDelegate

- (void)searchButtonWasPressedForSearchView:(SearchView *)searchView {
   
    // 1.创建热门搜索
    NSArray *hotSeaches = @[@"标准物质", @"二硫化碳", @"甲醇"];
    // 2. 创建控制器
    
    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索商品或店铺" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
        // 开始搜索执行以下代码
        // 如：跳转到指定控制器
        
    }];
    

    searchViewController.definesPresentationContext = YES;
       searchViewController.automaticallyAdjustsScrollViewInsets = NO;
    // 3. 设置风格
    searchViewController.hotSearchStyle = 0; // 热门搜索风格根据选择
    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
    // 4. 设置代理
    searchViewController.delegate = self;
    // 5. 跳转到搜索控制器

    [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:searchViewController animated:YES];

//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//    [[[Singleton shardeManger]getCurrentVC] presentViewController:nav  animated:NO completion:nil];
    
}

- (IBAction)chooseBtnClick:(UIButton *)sender {
    self.index = sender.tag;
    if (sender.tag == 100) {
        self.flab.textColor = mainColor;
        self.fnumLab.textColor = mainColor;
        self.snumLab.textColor = RGB(114, 115, 116);
        self.slab.textColor = RGB(114, 115, 116);
        self.tlab.textColor = RGB(114, 115, 116);
        self.tnumLab.textColor = RGB(114, 115, 116);
    }else if (sender.tag == 200){
        self.snumLab.textColor = mainColor;
        self.slab.textColor = mainColor;
        self.flab.textColor = RGB(114, 115, 116);
        self.fnumLab.textColor = RGB(114, 115, 116);
        self.tlab.textColor = RGB(114, 115, 116);
        self.tnumLab.textColor = RGB(114, 115, 116);
    }else{
        self.tlab.textColor = mainColor;
        self.tnumLab.textColor = mainColor;
        self.flab.textColor = RGB(114, 115, 116);
        self.fnumLab.textColor = RGB(114, 115, 116);
        self.snumLab.textColor = RGB(114, 115, 116);
        self.slab.textColor = RGB(114, 115, 116);
    }
    [self requestData];
}



@end
