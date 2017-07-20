//
//  LNThreeViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "LNThreeViewController.h"

@interface LNThreeViewController ()

@property (nonatomic, copy) void(^block)();



@end

@implementation LNThreeViewController


- (NSString *)controllerTitle {
    return @"Block内存管理(MRC)";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //static int a = 3;// 静态变量
    //__block int a = 3;// 还是局部变量
    void(^block)() = ^{
        
//        NSLog(@"调用block%d",a);
        NSLog(@"调用block");
    };

    self.block = block;
    
    NSLog(@"%@",self.block);
}




//--------------------------- <#我是分割线#> ------------------------------//
//

/**
 总结:
 1.只要block没有引用外部局部变量,block放在全局区
 2.只要Block引用外部局部变量,block放在栈里面.
 3.block只能使用copy,不能使用retain. 原因:使用retain,block还是在栈里面,代码块已过就会被销毁了。
 
//--------------------------- Block内存管理(MRC) ------------------------------//
//
void(^block)() = ^{
    NSLog(@"调用block");
};

NSLog(@"%@",block);
 
2017-03-30 20:15:56.054 Block详解[23533:817404] <__NSGlobalBlock__: 0x102080320>

 
 
 
//--------------------------- Block内存管理(MRC) ------------------------------//
//
 //static int a = 3;// 静态变量
 __block int a = 3;// 还是局部变量
 void(^block)() = ^{
 
 NSLog(@"调用block%d",a);
 };
 
 NSLog(@"%@",block);
 
 2017-03-30 20:22:12.458 Block详解[23762:824109] <__NSMallocBlock__: 0x60800005eff0>

 
 
 
 
 //--------------------------- Block内存管理(MRC) ------------------------------//
 //
 
 @property (nonatomic, retain) void(^block)();
 用retain打印输出：
 2017-03-30 20:31:06.321 Block详解[23953:833320] <__NSMallocBlock__: 0x608000056530>

 
 
 @property (nonatomic, copy) void(^block)();
 用copy打印输出：
 2017-03-30 20:34:06.872 Block详解[24033:837243] <__NSGlobalBlock__: 0x10db8b320>

 */


@end























