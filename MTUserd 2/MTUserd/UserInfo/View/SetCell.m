//
//  SetCell.m
//  MTUserd
//
//  Created by 伯爵 on 2019/11/12.
//  Copyright © 2019 MTShopd. All rights reserved.
//

#import "SetCell.h"
#import "FltkViewController.h"
#import "YjfkViewController.h"
#import "AboutUsViewController.h"
#import "ContactUsViewController.h"
#import <SDImageCache.h>
#import "CleanCaches.h"

@implementation SetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.topView.hidden = YES;
}


- (IBAction)setCellBtnClick:(UIButton *)sender {
    switch (sender.tag) {
        case 100:{
            FltkViewController *fltkVC = [[FltkViewController alloc]init];
            [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:fltkVC animated:YES];
        }
            break;
        case 200:{
            YjfkViewController *yjfkVC = [[YjfkViewController alloc]init];
            [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:yjfkVC animated:YES];
        }
            break;
        case 300:{
            AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
            [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:aboutUsVC animated:YES];
        }
            break;
        case 400:{
            ContactUsViewController *contactUsVC = [[ContactUsViewController alloc]init];
            [[[Singleton shardeManger]getCurrentVC].navigationController pushViewController:contactUsVC animated:YES];
        }
            break;
        case 500:{
            
            NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
            NSString *cachesDir = [paths objectAtIndex:0];
            float size = [CleanCaches folderSizeAtPath:cachesDir];
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清理" message:[NSString stringWithFormat:@"已清理%.2lfM缓存", size] preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                [CleanCaches clearCache:cachesDir];
                
            }];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:okAction];
            [alert addAction:cancelAction];
            [[[Singleton shardeManger]getCurrentVC] presentViewController:alert animated:YES completion:nil];

            
//            NSUInteger bytesCache = [[SDImageCache sharedImageCache] totalDiskSize];
//            //换算成 MB (注意iOS中的字节之间的换算是1000不是1024)
//            float MBCache = bytesCache/1000.00/1000.00;
//            NSLog(@"=====::%f",MBCache);
            
//            dispatch_async(dispatch_get_global_queue(0, 0), ^{
//                 [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
//           });

        }
            break;
            
        case 700:{
            [self quitClick];
        }
            break;
            
        default:
            break;
    }
}
-(void)quitClick{
     [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"user_token"];
    [self presentLoginVC];
}
-(void)presentLoginVC{
    
   LoginViewController *login = [[LoginViewController alloc]init];
   BaseNavigationController *logNavi = [[BaseNavigationController alloc]initWithRootViewController:login];
   [[NSObject getCurrentVC] presentViewController:logNavi animated:YES completion:nil];
}
@end
