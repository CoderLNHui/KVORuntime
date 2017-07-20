//
//  LNTwoViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "LNTwoViewController.h"
#import "LNModalViewController.h"

@interface LNTwoViewController () // <LNModalViewControllerDelegate>

@end

@implementation LNTwoViewController


- (NSString *)controllerTitle {
    return @"Block传值 & 代理传值";
}

//  LNTwoViewController.m
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    LNModalViewController *modalVC = [[LNModalViewController alloc] init];
    
    //modalVC.delegate = self;
    
    
    //--------------------------- <#我是分割线#> ------------------------------//
    //
    
    // Block接收值(参数值),保存代码
    modalVC.LNBlock = ^(NSString *value){
        NSLog(@"%@",value);
    };
    
    
    [self presentViewController:modalVC animated:YES completion:nil];
}

// 5.遵守协议,实现协议方法（接收值）
//- (void)modalViewController:(LNModalViewController *)modalVc sendValue:(NSString *)value {
//    NSLog(@"%@",value);
//}




@end



























