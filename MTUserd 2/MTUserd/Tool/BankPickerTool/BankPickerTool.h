//
//  SexPickerTool.h
//  PickerView
//
//  Created by  zengchunjun on 2017/4/20.
//  Copyright © 2017年  zengchunjun. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^BankPickBlock)(NSString *pickDate);
typedef void(^PickBlock)(NSString *pickDate,NSString *idStr);

@interface BankPickerTool : UIView

@property (weak, nonatomic) IBOutlet UILabel *pickerTitleLab;
@property (nonatomic,strong)BankPickBlock callBlock;

@property (nonatomic,strong)PickBlock dataBlock;
@property (nonatomic,strong)NSMutableArray *idArr;


- (void)reloadArray:(NSMutableArray *)kaHaoArray;
@end
