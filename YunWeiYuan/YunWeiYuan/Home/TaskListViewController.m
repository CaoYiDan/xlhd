//
//  TaskListViewController.m
//  YunWeiYuan
//
//  Created by 伯爵 on 2020/2/24.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "TaskListViewController.h"
#import "TaskListCell.h"
#import "TaskListModel.h"

@interface TaskListViewController ()

@property (weak, nonatomic) IBOutlet UIView *chooseView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,strong)NSString *indexStr;

@end
static NSString *const cellId = @"cellId";
@implementation TaskListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务列表";
    [self createTableView];
    self.tableView.top = 40;
    self.tableView.height = self.tableView.height - 40;
    [self setupView];
    self.indexStr = @"0";
    [self requestData:@"0"];
}

- (void)setupView{
    [self.chooseView setBorderLineWithColor:mainColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([TaskListCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
}

- (void)requestData:(NSString *)doneStr{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:@"10" forKey:@"limit"];
    [param setValue:@"1" forKey:@"page"];
    [param setValue:doneStr forKey:@"status"];
     NSMutableDictionary *jsonStr = param;
//    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@repair/list",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[TaskListModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TaskListCell *cell = [TaskListCell loadFromNIB];
    if (!cell) {
        cell = [[TaskListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 150;
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
        self.indexStr = @"0";
    }else{
        self.indexStr = @"1";
    }
    [self requestData:self.indexStr];
}

@end
