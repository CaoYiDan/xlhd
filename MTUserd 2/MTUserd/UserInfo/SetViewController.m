//
//  SetViewController.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/12.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "SetViewController.h"
#import "SetCell.h"

@interface SetViewController ()

@end
static NSString *const cellId = @"cellId";
@implementation SetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title = @"设置";
    [self createTableView];
    
    [self setupView];
 
}

- (void)setupView{
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([SetCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SetCell *cell = [SetCell loadFromNIB];
    if (!cell) {
        cell = [[SetCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 500;
}
@end
