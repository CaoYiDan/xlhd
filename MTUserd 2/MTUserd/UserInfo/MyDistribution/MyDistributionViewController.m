//
//  MyDistributionViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/15.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "MyDistributionViewController.h"
#import "DistributionCell.h"

@interface MyDistributionViewController ()

@property (weak, nonatomic) IBOutlet UIButton *txBtn;

@end
static NSString *const cellId = @"cellId";
@implementation MyDistributionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的订单";
    [self createTableView];
    self.tableView.top = 140;
    self.tableView.height = self.tableView.height - 140;
    [self setupView];
 
}

- (void)setupView{
    [self.txBtn setBorderLineWithColor:mainColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DistributionCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DistributionCell *cell = [DistributionCell loadFromNIB];
    if (!cell) {
        cell = [[DistributionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (IBAction)txBtnClick:(UIButton *)sender {
    
}


@end
