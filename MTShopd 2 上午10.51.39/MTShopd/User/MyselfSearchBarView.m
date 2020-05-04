//
//  MyselfSearchBarView.m
//  MTShopd
//
//  Created by MAC on 2020/4/28.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import "MyselfSearchBarView.h"

@implementation MyselfSearchBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.userInteractionEnabled = YES;
        [self addSubview:self.search];
        [self.search becomeFirstResponder];
    }
    return self;
}
-(UISearchBar*)search{

    if(!_search) {

     _search=[[UISearchBar alloc]initWithFrame:CGRectMake(20,64,ScreenWidth-40,35)];

        [self.search setSearchBarStyle:UISearchBarStyleMinimal];

        [self.search setPlaceholder:@"药品商品名/拼音首字母"];

        self.search.tintColor=KmainColor_ls;

        self.search.delegate=self;

        // ** 自定义searchBar的样式 **

        UITextField* searchField =nil;

        // 注意searchBar的textField处于孙图层中

        for(UIView* view  in[_search.subviews firstObject].subviews) {

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

                // 删除searchBar输入框的背景

                [searchField setBackground:nil];

                [searchField setBorderStyle:UITextBorderStyleNone];

                //设置文本框的背景颜色

                searchField.backgroundColor= KmainColor_ls;

                // 设置圆角

                searchField.layer.cornerRadius=3;

                searchField.layer.masksToBounds=YES;

                break;

            }

        }

    }

    return _search;

}
@end
