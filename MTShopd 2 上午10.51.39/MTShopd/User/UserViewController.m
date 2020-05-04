//
//  UserViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2019/11/7.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "UserViewController.h"
#import "UserCell.h"
#import "UserInfoViewController.h"
#import "UserListModel.h"
#import "RightViewController.h"
#import "UserRightView.h"
#import "QFDatePickerView.h"
#import "MyselfSearchBarView.h"
#import "EPTSearchBar.h"
#import "UISearchBar+JCSearchBarPlaceholder.h"

@interface UserViewController ()<UITextFieldDelegate,SearchViewDelegate,PYSearchViewControllerDelegate,UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UIView *sView;
@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,strong)UserListModel *model;
@property (nonatomic ,strong)UserRightView *rightView;
@property (nonatomic ,assign)NSInteger jfTypeStr;
@property (nonatomic ,assign)NSInteger jfKindStr;
@property (nonatomic ,copy)NSString *timeStr;
@property (nonatomic ,copy)NSString *searchWord;
@property (nonatomic, strong) UISearchBar *searchBar;
@end

static NSString *const cellId = @"cellId";

@implementation UserViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.searchWord = @"";
    
//   EPTSearchBar *searchBar = [[EPTSearchBar alloc] init];
//    searchBar.frame = CGRectMake(0, 64, ScreenWidth-100, 44);
//    self.searchBar = searchBar;
//    self.searchBar.delegate = self;
//    // 显示(bookmark)语音按钮
//    [self.searchBar setShowsBookmarkButton:NO];
//    // 设置靠左显示的placeholder
//    [self.searchBar changeLeftPlaceholder:@"请输入关键字"];
//
//    [self.view addSubview:searchBar];
//    return;
    self.title = @"用户管理";
    //[self createTableView];
   
    [self setupView];
    
    [self requestData];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateListClick) name:@"updateList" object:nil];
    self.tableView.frame = CGRectMake(0, 52, ScreenWidth, ScreenHeight-52-SafeHeight64);
    
}

- (void)updateListClick{
    [self requestData];
}

- (void)setupView{

    self.rightView = [UserRightView loadFromNIB];
    self.rightView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
    
    [self.rightView.buyBtn addTarget:self action:@selector(rightViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView.ensureBtn addTarget:self action:@selector(rightViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView.timeBtn addTarget:self action:@selector(rightViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView.xsBtn addTarget:self action:@selector(rightViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView.xxBtn addTarget:self action:@selector(rightViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView.czBtn addTarget:self action:@selector(rightViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightView.yjBtn addTarget:self action:@selector(rightViewBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.rightView];
    UITapGestureRecognizer *sntapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sntapGestureClick)];
    [self.rightView addGestureRecognizer:sntapGesture];
    
    SearchView *searchView = [[SearchView alloc] initWithFrame:CGRectMake(30, 0, ScreenWidth - 60 - 80, 36)];
    searchView.textField.placeholder = @"请输入用户账户";
    [searchView setBorderLineWithColor:RGB(246, 246, 248)];
    [searchView setCornerRadius:18];
    [searchView.textField setTextColor:RGB(145, 156, 169)];
    searchView.textField.delegate = self;
//    searchView.textField.keyboardType = UIKeyboardTypeWebSearch;
    searchView.textField.returnKeyType = UIReturnKeySearch;
    [searchView becomeFirstResponder];
    [self.sView addSubview:searchView];
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([UserCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

#pragma  mark - TextFieldDelegate


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    self.searchWord = textField.text;
    [self requestData];
    [textField resignFirstResponder];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    NSLog(@"%@",textField.text);
//    self.searchWord = textField.text;
//    [self requestData];
//
}

- (void)rightViewBtnClick:(UIButton *)sender{
    
    if (sender.tag == 200){
        
        QFDatePickerView *datePickerView = [[QFDatePickerView alloc]initDatePackerWithSUperView:self.view response:^(NSString *str) {
            self.timeStr = str;
            [self.rightView.timeBtn setTitle:self.timeStr forState:UIControlStateNormal];
        }];
        [datePickerView show];
        
    }else if (sender.tag == 300){
        
        [self.rightView.xsBtn setTitleColor:mainColor forState:UIControlStateNormal];
        [self.rightView.xsBtn setBorderLineWithColor:mainColor];
        [self.rightView.xxBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [self.rightView.xxBtn setBorderLineWithColor:[UIColor clearColor]];
        self.jfTypeStr = 1;
        
    }else if (sender.tag == 400){
        
        [self.rightView.xxBtn setTitleColor:mainColor forState:UIControlStateNormal];
        [self.rightView.xxBtn setBorderLineWithColor:mainColor];
        [self.rightView.xsBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [self.rightView.xsBtn setBorderLineWithColor:[UIColor clearColor]];
        self.jfTypeStr = 0;
        
    }else if (sender.tag == 500){
        
        [self.rightView.buyBtn setTitleColor:mainColor forState:UIControlStateNormal];
        [self.rightView.buyBtn setBorderLineWithColor:mainColor];
        [self.rightView.yjBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [self.rightView.yjBtn setBorderLineWithColor:[UIColor clearColor]];
        self.jfKindStr = 1;
        
    }else if (sender.tag == 600){
        
        [self.rightView.yjBtn setTitleColor:mainColor forState:UIControlStateNormal];
        [self.rightView.yjBtn setBorderLineWithColor:mainColor];
        [self.rightView.buyBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [self.rightView.buyBtn setBorderLineWithColor:[UIColor clearColor]];
        self.jfKindStr = 0;
        
    }else if (sender.tag == 700){
        [self.rightView.xsBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [self.rightView.xsBtn setBorderLineWithColor:[UIColor clearColor]];
        [self.rightView.xxBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [self.rightView.xxBtn setBorderLineWithColor:[UIColor clearColor]];
        [self.rightView.buyBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [self.rightView.buyBtn setBorderLineWithColor:[UIColor clearColor]];
        [self.rightView.yjBtn setTitleColor:RGB(51, 51, 51) forState:UIControlStateNormal];
        [self.rightView.yjBtn setBorderLineWithColor:[UIColor clearColor]];
        self.jfTypeStr = 0;
        self.jfKindStr = 0;
        self.timeStr = @"";
        
    }else if (sender.tag == 800){
        [self requestData];
        self.rightView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
    }
}

- (void)requestData{
    
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"30" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
    if (self.jfTypeStr) {
        [param setValue:@(self.jfTypeStr) forKey:@"pay_battery_type"];
    }
    if (self.jfKindStr) {
        [param setValue:@(self.jfKindStr) forKey:@"use_battery_type"];
    }
    if (self.timeStr) {
        [param setValue:self.timeStr forKey:@"year_month"];
    }
    if (![self.searchWord isEqualToString:@""]) {
        [param setObject:self.searchWord forKey:@"phone_number"];
    }
    
     NSMutableDictionary *jsonStr = param;
    NSLog(@"%@",param);
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager]  postBossDemoWithUrl:[NSString stringWithFormat:@"%@user",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[UserListModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (void)sntapGestureClick{
    self.rightView.frame = CGRectMake(ScreenWidth, 0, ScreenWidth, ScreenHeight);
}

//- (void)rightBtn{
//
//}
//
//- (void)leftBtn{
//    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc]init];
//    [self.navigationController pushViewController:userInfoVC animated:YES];
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCell *cell = [UserCell loadFromNIB];
    if (!cell) {
        cell = [[UserCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 186;
}


#pragma mark - SearchViewDelegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"%@",searchBar.text);
    self.searchWord = searchBar.text;
    [self requestData];
}

- (void)searchButtonWasPressedForSearchView:(SearchView *)searchView {
   
//    // 1.创建热门搜索
//    NSArray *hotSeaches = @[@"标准物质", @"二硫化碳", @"甲醇"];
//    // 2. 创建控制器
//
//    PYSearchViewController *searchViewController = [PYSearchViewController searchViewControllerWithHotSearches:hotSeaches searchBarPlaceholder:@"搜索商品或店铺" didSearchBlock:^(PYSearchViewController *searchViewController, UISearchBar *searchBar, NSString *searchText) {
//        // 开始搜索执行以下代码
//        // 如：跳转到指定控制器
//
//    }];
//
//    searchViewController.definesPresentationContext = YES;
//       searchViewController.automaticallyAdjustsScrollViewInsets = NO;
//    // 3. 设置风格
//    searchViewController.hotSearchStyle = 0; // 热门搜索风格根据选择
//    searchViewController.searchHistoryStyle = PYHotSearchStyleDefault; // 搜索历史风格为default
//    // 4. 设置代理
//    searchViewController.delegate = self;
//    // 5. 跳转到搜索控制器
//
//    [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:searchViewController animated:YES];

//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:searchViewController];
//    [[[Singleton shardeManger]getCurrentVC] presentViewController:nav  animated:NO completion:nil];
    
}

- (IBAction)shuaiXuanBtnClick:(UIButton *)sender {
//    UINavigationController *centerNC = self.childViewControllers.lastObject;
////    LeftViewController *leftVC = self.childViewControllers.firstObject;
//    RightViewController *rightVC = self.childViewControllers[1];
//    [UIView animateWithDuration:0.5 animations:^{
//
//        if ( centerNC.view.center.x != self.view.center.x ) {
//
//
//            NSLog(@"1回来");
////            leftVC.view.frame = CGRectMake(0, 0, 250, [UIScreen mainScreen].bounds.size.height);
//            rightVC.view.frame = CGRectMake([UIScreen mainScreen].bounds.size.width - 250, 0, 250, [UIScreen mainScreen].bounds.size.height);
//            centerNC.view.frame = [UIScreen mainScreen].bounds;
//
//        }else{
//            centerNC.view.frame = CGRectMake(-250, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
////            leftVC.view.frame =CGRectMake(-250, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
//        }
//    }];
    self.rightView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
}

@end
