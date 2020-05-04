//
//  MessageViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/12.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageCell.h"
#import "MessageModel.h"

@interface MessageViewController ()

@property (nonatomic ,strong)NSArray *dataArray;

@end
static NSString *const cellId = @"cellId";
@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"任务消息";
    [self createTableView];
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self setupView];
    [self requestData];
}

- (void)setupView{
//    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"消息"] style:UIBarButtonItemStylePlain target:self action:@selector(rightBtn)];
//    self.navigationItem.rightBarButtonItem = rightBarItem;
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([MessageCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (void)requestData{
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@notice/notices",base_url] param:nil success:^(NSDictionary *dict) {            
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[MessageModel class] json:dict[@"data"]];
            [self.tableView reloadData];
        }else{
            [self showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
    }];
}

//- (void)rightBtn{
//
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MessageCell *cell = [MessageCell loadFromNIB];
    if (!cell) {
        cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
