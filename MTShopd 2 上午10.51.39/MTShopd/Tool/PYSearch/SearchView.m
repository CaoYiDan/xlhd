//
//  SearchView.m
//  SearchControllerDemo
//
//  Created by admin on 16/8/30.
//  Copyright © 2016年 thomas. All rights reserved.
//

#import "SearchView.h"

@implementation SearchView

#pragma mark - life cycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
                                      owner:self
                                    options:nil];
        self.view.frame = frame;
        [self setupViews];
        [self addSubview:self.view];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.view.frame = self.frame;
}

#pragma mark - Private

- (void)setupViews {
    
//    self.textField.layer.cornerRadius = 18.0f;
//    self.textField.layer.masksToBounds = YES;
//    [self.textField setValue:[UIColor whiteColor]
//                  forKeyPath:@"_placeholderLabel.textColor"];
//    self.textField.tintColor = [UIColor colorWithRed:98 / 255.0f green:97 / 255.0f blue: 101 / 255.0f alpha:1.0f];
//    self.textField.tintColor = [UIColor grayColor];
//
//
//    self.textField.backgroundColor = [UIColor whiteColor];
//    self.textField.alpha = 0.3;
    self.searchButton.hidden = YES;
    [self setupTextFieldLeftView];
}

- (void)setupTextFieldLeftView {
    
    UIImageView *searchImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    searchImageView.image = [UIImage imageNamed:@"搜索"];
    searchImageView.contentMode = UIViewContentModeCenter;
    [self addSubview:searchImageView];
   
}

//- (IBAction)searchButtonWasPressed:(UIButton *)sender {
//    if ([self.delegate respondsToSelector:@selector(searchButtonWasPressedForSearchView:)]) {
//        [self.delegate searchButtonWasPressedForSearchView:self];
//    }
//}

@end
