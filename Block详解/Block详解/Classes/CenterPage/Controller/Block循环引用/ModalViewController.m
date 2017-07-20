//
//  ModalViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "ModalViewController.h"

@interface ModalViewController ()

@property (nonatomic, strong) void(^block)();
@end

@implementation ModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    //--------------------------- 我是分割线 ------------------------------//
    //
    
    // 这种情况下回造成循环引用
    // block造成循环问题:Block会对里面所有 强指针变量(如:self) 都强引用一次
    //    _block = ^{
    //        NSLog(@"%@",self);
    //    };
    
    // 解决防止Block造成循环引用问题,改成弱引用
    //    __weak typeof(self) weakSelf = self;
    //    _block = ^{
    //        NSLog(@"%@",weakSelf);
    //    };
    //
    
    
    //--------------------------- Block循环引用进阶(三方框架中学习) ------------------------------//
    //
    
    // 需求:Block里面要访问控制器对象做些事情，这时如果Block内部有延迟操作，就会拿不到控制器对象。
    // 解决:
    __weak typeof(self) weakSelf = self;
    
    _block = ^{
        
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{ // 这里的block 和外面的block不是同一个.
            
            NSLog(@"%@",strongSelf);
        });
    };
    
    _block();// 调用
    
    /**
     内部代码块,使用weakSelf 打印输出
     2017-03-31 00:15:08.861 Block详解[25029:875491] ModalViewController销毁
     2017-03-31 00:15:09.835 Block详解[25029:875491] (null)
    
     内部代码块,使用strongSelf 打印输出
     2017-03-31 00:18:47.966 Block详解[25117:877961] <ModalViewController: 0x7f89f0c07030>
     2017-03-31 00:18:47.966 Block详解[25117:877961] ModalViewController销毁
     */
    
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    // 如果控制器被dismiss就会被销毁
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)dealloc
{
    NSLog(@"ModalViewController销毁");
}




@end














