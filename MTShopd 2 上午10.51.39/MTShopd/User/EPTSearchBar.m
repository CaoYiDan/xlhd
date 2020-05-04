//
//  EPTSearchBar.m
//  searchTest
//
//  Created by HuangXJ on 2017/9/2.

#import "EPTSearchBar.h"
#import "UIColor+HexString.h"

@implementation EPTSearchBar
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // 设置默认为“搜索”
        self.placeholder = @"搜索";
        // 设置输入光标与取消按钮颜色
        self.tintColor = [UIColor WPLBlueColor];
        // 设置searchBar背景色
        self.barTintColor = [UIColor whiteColor];
        // 设置searchBar背景图片
        [self setBackgroundImage:[UIImage new]];
        // 获取UISearchBar中的textField
        UITextField *textField = [self getFiled];
        // 设置textField的背景色
        CGFloat textFieldBackgroundColorValue = 236 / 255.0;
        UIColor *textFieldBackgroundColor = [UIColor colorWithRed:textFieldBackgroundColorValue green:textFieldBackgroundColorValue blue:textFieldBackgroundColorValue alpha:1];
        textField.backgroundColor = textFieldBackgroundColor;
        // 设置输入文字颜色
        textField.textColor = [UIColor WPLDarkGrayColor];
        // 设置搜索图标
        [self setImage:[UIImage imageNamed:@"search_btn.png"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
        // 设置搜索图标尺寸
        textField.leftView.bounds = CGRectMake(0, 0, 20, 20);
        // 设置清除按钮图片
        [self setImage:[UIImage imageNamed:@"empty_search_btn.png"] forSearchBarIcon:UISearchBarIconClear state:UIControlStateNormal];
        // 设置语音按钮图片
        [self setImage:[UIImage imageNamed:@"empty_search_btn.png"] forSearchBarIcon:UISearchBarIconBookmark state:UIControlStateNormal];
        
        // 添加searchBar底部分割线
        UIView *bottomSeparateView = [UIView new];
        bottomSeparateView.backgroundColor = [UIColor WPLSeparateLineGrayColor];
        bottomSeparateView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:bottomSeparateView];
        [self addConstraints:@[
                               [NSLayoutConstraint constraintWithItem:bottomSeparateView
                                                            attribute:NSLayoutAttributeLeft
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeLeft
                                                           multiplier:1.0
                                                             constant:0],
                               [NSLayoutConstraint constraintWithItem:bottomSeparateView
                                                            attribute:NSLayoutAttributeRight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeRight
                                                           multiplier:1.0
                                                             constant:0],
                               [NSLayoutConstraint constraintWithItem:bottomSeparateView
                                                            attribute:NSLayoutAttributeBottom
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:self
                                                            attribute:NSLayoutAttributeBottom
                                                           multiplier:1.0
                                                             constant:0],
                               [NSLayoutConstraint constraintWithItem:bottomSeparateView
                                                            attribute:NSLayoutAttributeHeight
                                                            relatedBy:NSLayoutRelationEqual
                                                               toItem:nil attribute:NSLayoutAttributeNotAnAttribute
                                                           multiplier:1.0
                                                             constant:0.5]
                               ]];

    }
    
    return self;
}

-(UITextField *)getFiled{
    
     UITextField* searchField =nil;

            // 注意searchBar的textField处于孙图层中

            for(UIView* view  in[self.subviews firstObject].subviews) {

                NSLog(@"UISearchBar：%@", view.class);

                UIView*subview=view;

                if(@available(iOS 13.0, *)) {

                    if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]){

                        //去掉背景颜色

                        [((UIImageView*)view)setImage:nil];

                    }

                    if ([view isKindOfClass:NSClassFromString(@"_UISearchBarSearchContainerView")]){

                        //ios13输入文本框又往里移了一层

                        subview=[view.subviews firstObject];

                    }

                }

                if([subview isKindOfClass:[UITextField class]]) {

                    searchField = (UITextField*)subview;
        return searchField;

                }

            }
    return searchField;
}
@end
