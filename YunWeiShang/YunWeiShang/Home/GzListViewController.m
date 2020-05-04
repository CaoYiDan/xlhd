//
//  GzListViewController.m
//  YunWeiShang
//
//  Created by 伯爵 on 2020/3/2.
//  Copyright © 2020 GangMeiTanGongXu. All rights reserved.
//

#import "GzListViewController.h"
#import "GzListCell.h"
#import "GzDetailViewController.h"
#import "GzListModel.h"

@interface GzListViewController ()

@property (weak, nonatomic) IBOutlet UIView *chooseView;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *buttons;
@property (nonatomic ,strong)NSArray *dataArray;
@property (nonatomic ,strong)NSString *indexStr;
@property (weak, nonatomic) IBOutlet UIButton *leftBtn;
@property (weak, nonatomic) IBOutlet UIButton *rightBtn;
@property(nonatomic,assign)NSInteger selectedIndex;
@end
static NSString *const cellId = @"cellId";
@implementation GzListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
//    [self requestData:@"0"];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"故障列表";
    self.indexStr = @"0";
    self.selectedIndex = 0;
    [self createTableView];
    self.tableView.top = 40;
    self.tableView.height = self.tableView.height - 40;
    [self setupView];
}

- (void)setupView{
    [self.chooseView setBorderLineWithColor:mainColor];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([GzListCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
}

- (void)requestData:(NSString *)doneStr{
    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    if (self.model.device_code) {
        [param setValue:self.model.device_code forKey:@"device_code"];
    }
    [param setValue:doneStr forKey:@"done"];
    NSMutableDictionary *jsonStr = param;
    //NSMutableDictionary *jsonStr = param;
    //NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@warning/list",base_url] param:jsonStr success:^(NSDictionary *dict) {
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[GzListModel class] json:dict[@"data"]];
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
    GzListCell *cell = [GzListCell loadFromNIB];
    if (!cell) {
        cell = [[GzListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 110;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    GzListModel *model = self.dataArray[indexPath.row];
    GzDetailViewController *gzDetailVC = [[GzDetailViewController alloc]init];
    gzDetailVC.model = model;
    [self.navigationController pushViewController:gzDetailVC animated:YES];
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
