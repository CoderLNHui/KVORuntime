//
//  LNFourViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "LNFourViewController.h"

@interface LNFourViewController ()

@property (nonatomic, strong) void(^block)();
//@property (nonatomic, copy) void(^block)();
@end

@implementation LNFourViewController

// 这个代码是属性定义strong要进行的操作,直接赋值
//- (void)setName:(NSString *)name
//{
//    _name = name;
//}

// 这个代码是属性定义copy要进行的操作，会在内部判断是否需要分布新的内存，如可变给不可变赋值需要分布内存，若不可变给不可变赋值就没必要分布内存（没有必须进行copy内部其它操作）
//- (void)setName:(NSString *)name
//{
//    _name = [name copy];
//}



- (NSString *)controllerTitle {
    return @"Block内存管理(ARC)";
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 堆 栈 全局区
    
    int a = 3;
    
    void(^block)() = ^{
        
        NSLog(@"%d",a);
        
    };
    
    _block =  block;
    NSLog(@"%@",_block);
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    _block();
    
}


@end





















