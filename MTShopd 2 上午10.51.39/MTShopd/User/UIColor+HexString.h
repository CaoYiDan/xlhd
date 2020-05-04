//
//  UIColor+HexString.h
//
//  Created by Micah Hainline
//  http://stackoverflow.com/users/590840/micah-hainline
//

#import <UIKit/UIKit.h>

@interface UIColor (HexString)

+ (UIColor *) colorWithHexString: (NSString *) hexString;

/**
 工作平台中常用颜色
 */

/**
 蓝色

 @return #3C80E6
 */
+ (UIColor *)WPLBlueColor;

/**
 浅灰色
 
 @return #999999
 */
+ (UIColor *)WPLLightGrayColor;

/**
 中灰色
 
 @return #666666
 */
+ (UIColor *)WPLNormalGrayColor;

/**
 中灰色
 
 @return #333333
 */
+ (UIColor *)WPLDarkGrayColor;

/**
 页面默认背景色
 
 @return RGB 0.95
 */
+ (UIColor *)WPLDefaultBackgroundGrayColor;

/**
 cell分割线颜色

 @return #E0E0E0
 */
+ (UIColor *)WPLSeparateLineGrayColor;


@end
