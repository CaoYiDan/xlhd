//
//  TuiZuManagerViewController.m
//  MTShopd
//
//  Created by 伯爵 on 2020/4/15.
//  Copyright © 2020 MTShopd. All rights reserved.
//
#import "QuitLeaseCell.h"
#import "BLDatePickerView.h"
#import "TuiZuManagerViewController.h"

@interface TuiZuManagerViewController ()<BLDatePickerViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *quitLeaseNum;////退租人数
@property (weak, nonatomic) IBOutlet UILabel *quitBatteryNum;////累计腿电池用户
@property (weak, nonatomic) IBOutlet UILabel *currentQuitNum;////本月退租人数
@property (weak, nonatomic) IBOutlet UILabel *currentQuitBatteryNum;////本月退电池用户
@property (weak, nonatomic) IBOutlet UIButton *selectedMonthBtn;////月份筛选按钮
@property (weak, nonatomic) IBOutlet UIButton *respectBtn;////重制按钮
@property (weak, nonatomic) IBOutlet UILabel *seleetedDateLabel;

/**  */
@property (nonatomic, strong) BLDatePickerView *datePickerView;
@end

@implementation TuiZuManagerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"退租管理";

    self.view.backgroundColor = RGB(245, 247, 250);
    [self setupView];
    
    self.dataArr = @[@"fd",@"",@"",@"",@"fd",@"",@"",@""];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(0);
        makeTopOffSet(self.respectBtn.mas_bottom, 5);
        make.width.offset(ScreenWidth);
        make.bottom.offset(0);
    }];

}

- (IBAction)selectedDate:(id)sender {
    [self.datePickerView bl_show];
}

- (IBAction)respectClick:(id)sender {
    
}


- (void)setupView{
    
}
#pragma  mark  - TableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuitLeaseCell *cell = [QuitLeaseCell loadCode:tableView];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 120;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

#pragma mark - - lazy load
// 第一步
- (BLDatePickerView *)datePickerView{
    if (!_datePickerView) {
        _datePickerView = [[BLDatePickerView alloc] init];
        _datePickerView.pickViewDelegate = self;
        [_datePickerView bl_setUpDefaultDateWithYear:2020 month:4 day:1];
        /** 可设置的属性 */
//         /** 标题大小 */
//        @property (nonatomic, strong)UIFont  *titleFont;
//        /** 选择器背景颜色 */
//        @property (nonatomic, strong)UIColor *pickViewBackgroundColor;
//        /** 选择器头部视图颜色 */
//        @property (nonatomic, strong)UIColor *topViewBackgroundColor;
//        /** 取消按钮颜色 */
//        @property (nonatomic, strong)UIColor *cancelButtonColor;
//        /** 确定按钮颜色 */
//        @property (nonatomic, strong)UIColor *sureButtonColor;
//        /** 设置背景透明度 0~1 */
//        @property (nonatomic, assign)CGFloat backGAlpha;
        
    }
    return _datePickerView;
}

#pragma mark - - BLDatePickerViewDelegate
// 第三步
- (void)bl_selectedDateResultWithYear:(NSString *)year
                                month:(NSString *)month
                                  day:(NSString *)day{
    NSString *dateStr = [NSString stringWithFormat:@"%@-%@",year,month];
    
    self.seleetedDateLabel.text = dateStr;
    
}

@end
