//
//  MyselfSearchBarView.h
//  MTShopd
//
//  Created by MAC on 2020/4/28.
//  Copyright © 2020 MTShopd. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyselfSearchBarView : UIView<UISearchBarDelegate>
/** UISearchBar */
@property (nonatomic, strong) UISearchBar *search;
@end

NS_ASSUME_NONNULL_END
