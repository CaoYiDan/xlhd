//
//  SexPickerTool.m
//  PickerView
//
//  Created by  zengchunjun on 2017/4/20.
//  Copyright © 2017年  zengchunjun. All rights reserved.
//

#import "BankPickerTool.h"

@interface BankPickerTool ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)NSMutableArray *dataSource;

@property (weak, nonatomic) IBOutlet UIPickerView *pickerView;

@property (nonatomic,strong)NSString *sexPick;

@property (nonatomic,strong)NSString *idStr;


@end

@implementation BankPickerTool

//- (NSMutableArray *)dataSource
//{
//    if (_dataSource == nil) {
//        _dataSource = [NSMutableArray arrayWithObjects:@"支付宝",@"微信",@"银行卡", nil];
//    }
//    return _dataSource;
//}


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"BankPickerTool" owner:nil options:nil]firstObject];
    }
    self.frame = frame;
    return self;
}

- (void)reloadArray:(NSMutableArray *)kaHaoArray{
    _dataSource = kaHaoArray;
    if (self.dataSource.count != 0) {
        self.sexPick = self.dataSource[0];
    }
    [self.pickerView reloadAllComponents];

}
- (void)awakeFromNib
{
    [super awakeFromNib];
    self.pickerView.showsSelectionIndicator = YES;
    self.sexPick = self.dataSource[0];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (IBAction)pickDone:(UIButton *)sender {
    
//    self.callBlock(self.sexPick);
    if (self.idArr.count != 0) {
        self.idStr = self.idArr[0];
        self.dataBlock(self.sexPick, self.idStr);

    }else{
        self.callBlock(self.sexPick);
    }
}


- (IBAction)pickCancel:(UIButton *)sender {
    if (self.dataSource.count != 0) {
        self.sexPick = self.dataSource[0];
    }
    if (self.idArr.count != 0) {
        self.idStr = self.idArr[0];
        self.dataBlock(self.sexPick, self.idStr);

    }else{
        self.callBlock(self.sexPick);
    }
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%ld",row+1];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.sexPick = [NSString stringWithFormat:@"%ld",row+1];
    self.idStr = [NSString stringWithFormat:@"%ld",row+1];
}
//-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    
//    UILabel *lbl = (UILabel *)view;
//    
//    if (lbl == nil) {
//        
//        lbl = [[UILabel alloc]init];
//        
//        //在这里设置字体相关属性
//        
//        lbl.font = [UIFont systemFontOfSize:17];
//        
//        lbl.textAlignment = UITextAlignmentCenter;
////        lbl.textColor = [UIColor redColor];
////
////        [lbl setBackgroundColor:[UIColor clearColor]];
//        
//    }
//    
//    //重新加载lbl的文字内容
//    
//    lbl.text = [self pickerView:pickerView titleForRow:row forComponent:component];
//    
//    return lbl;
//    
//}
@end
