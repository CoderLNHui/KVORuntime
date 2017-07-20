//
//  LNSevenViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
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










































