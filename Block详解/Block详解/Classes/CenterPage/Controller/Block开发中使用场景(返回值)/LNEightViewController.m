//
//  LNEightViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//
/**
 
 block开发中使用场景(返回值)
 
 体现了一种思想：
 链式编程思想:把所有的语句用.号连接起来, 好处:可读性非常好
 
 如： messay里的make.center.equalTo(ws.view);
 解析：make.center.equalTo得到一个block，make.center.equalTo(ws.view)去调用block
 
 self.test();
 解析：self.test();发两步：1、self.test是调用get方法，返回一个block，2、self.test()调用block
 
 需求:封装一个计算器,提供一个加号方法
 
 */

#import "LNEightViewController.h"
#import "CalculatorManager.h"

@interface LNEightViewController ()

@end

@implementation LNEightViewController

- (NSString *)controllerTitle {
    return @"Block开发中使用场景(返回值)";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //--------------- 需求:封装一个计算器,提供一个加号方法 -------------------//
    //
    
    CalculatorManager *mgr = [[CalculatorManager alloc] init];

    /**
     方式三：+ 5（欣赏）
     mgr.add(5).add(5).add(5).add(5).add(5).add(5)
     
     
     方式二：+ 5（可读性差）
     [[[[[mgr add:5] add:5] add:5] add:6] add:7];
     
     
     方式一：+ 5（可读性差）
     [mgr add:5];
     [mgr add:5];
     [mgr add:5];
     [mgr add:5];

     */
    mgr.add(5).add(5).add(5).add(5).add(5);
    NSLog(@"%d",mgr.result);
    
    //--------------------------- <#我是分割线#> ------------------------------//
    //
    
    //    make.center;
    //     make.center.equalTo(ws.view);
    //    self.test();
    //    void(^block)() = ^{
    //        NSLog(@"调用了block");
    //    };
    
//    self.test();
}

- (void(^)())test
{
    //    NSLog(@"%s",__func__);
    //    void(^block)() = ^{
    //
    //    };
    return ^{
        NSLog(@"调用了block");
    };
}




@end


























































