//
//  HomeListView.m
//  MTUserd
//
//  Created by 伯爵 on 2020/1/9.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "HomeListView.h"
#import "YyhdCell.h"

static NSString *const cellId = @"cellId";

@implementation HomeListView

- (void)awakeFromNib{
    [super awakeFromNib];
    self.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.3f];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YyhdCell class]) bundle:[NSBundle mainBundle]] forCellReuseIdentifier:cellId];
    [self requestData];

}

- (void)requestData{
    
    NSLog(@"=====:%@=======:%@",user_latitude,user_longitude);

    NSMutableDictionary *param = [[NSMutableDictionary alloc]init];
    [param setValue:user_latitude forKey:@"lat"];
    [param setValue:user_longitude forKey:@"lng"];
    [param setValue:@1000000 forKey:@"range"];
    [param setValue:@"1" forKey:@"need_book"];
    NSString *jsonStr = [[Singleton shardeManger]convertToJsonData:param];
    [[DataRequest Manager] postBossDemoWithUrl:[NSString stringWithFormat:@"%@charging-cabinet/pick-by-coordinates",base_url] param:jsonStr success:^(NSDictionary *dict) {        
        if ([dict[@"errorCode"]intValue] == 0) {
            self.dataArray = [NSArray yy_modelArrayWithClass:[HomeDianGuiModel class] json:dict[@"data"]];
            if (self.dataArray.count!=0) {
                self.hidden = NO;
            }
            [self.tableView reloadData];
        }else{
            [[[Singleton shardeManger]getCurrentVC]showHint:dict[@"message"]];
        }
    } fail:^(NSError *error) {
    }];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    YyhdCell *cell = [YyhdCell loadFromNIB];
    if (!cell) {
        cell = [[YyhdCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    [cell getDataWithInfo:self.dataArray[indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

@end
