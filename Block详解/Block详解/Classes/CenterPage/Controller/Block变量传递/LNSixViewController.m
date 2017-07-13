//
//  LNSixViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "LNSixViewController.h"

@interface LNSixViewController ()

@end

@implementation LNSixViewController


- (NSString *)controllerTitle {
    return @"Block变量传递";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 如果是局部变量,Block是值传递（外面修改不影响里面）
    
    int a = 3;
    void(^block1)() = ^{
        
        NSLog(@"block1--%d",a); // a为3
    };
    
    a = 5;
    
    block1(); // 调用
    
    
    //--------------------------- <#我是分割线#> ------------------------------//
    //
    
    // 如果是static静态变量,int全局变量,__block修饰的变量,block都是指针传递（外面的修改影响block里面的值）

    
    __block int b = 3;
    
    void(^block2)() = ^{
        
        NSLog(@"block2--%d",b); // a为5
    };
    
    b = 5;
    
    block2(); // 调用
    
    
    
    
    
    
    
    
    
    
    
}


@end

















