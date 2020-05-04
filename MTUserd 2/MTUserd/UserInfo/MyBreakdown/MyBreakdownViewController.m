//
//  MyBreakdownViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/15.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "MyBreakdownViewController.h"
#import "MyBreakdownCell.h"
#import "MyBreakdownModel.h"

@interface MyBreakdownViewController ()

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (nonatomic ,strong)NSArray *dataArray;
@end
static NSString *const cellId = @"cellId";
@implementation MyBreakdownViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的故障";
    [self createTableView];
    self.tableView.top = 44;
    self.tableView.height = self.tableView.height - 44;
    [self setupView];
    [self requestData];
}

- (void)setupView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MyBreakdownCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)requestData{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@ticket/pick",base_url] param:jsonStr success:^(NSDictionary *dict) {        
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[MyBreakdownModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
//         NSLog(@"%@",error);
    }];
    
}

- (IBAction)chooseBtnClick:(UIButton *)sender {
    for (UIButton *btn in self.buttons) {
        if (sender == btn) {
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.backgroundColor = mainColor;
        }else{
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            btn.backgroundColor = [UIColor clearColor];
        }
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MyBreakdownCell *cell = [MyBreakdownCell loadFromNIB];
    if (!cell) {
        cell = [[MyBreakdownCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 300;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


@end
