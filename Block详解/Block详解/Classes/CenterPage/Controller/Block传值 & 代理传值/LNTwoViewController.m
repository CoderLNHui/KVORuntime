//
//  LNTwoViewController.m
//  Block详解
//
//  Created by LN on 16/10/15.
//  Copyright © 2016年 Learning point. All rights reserved.
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



























