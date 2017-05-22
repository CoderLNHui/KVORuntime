//
//  LNSevenViewController.m
//  Block详解
//
//  Created by LN on 16/10/15.
//  Copyright © 2016年 Learning point. All rights reserved.
//



#import "LNSevenViewController.h"
#import "LNCacultorManager.h"

@interface LNSevenViewController ()

@end

@implementation LNSevenViewController


- (NSString *)controllerTitle {
    return @"Block开发使用场景(参数使用)";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 创建计算器管理者
    LNCacultorManager *mgr = [[LNCacultorManager alloc] init];
    [mgr cacultor:^(NSInteger result){
        result += 5;
        result += 6;
        result *= 2;
        return result;
    }];
    
    NSLog(@"%ld",mgr.result);
    
}


@end










































