//
//  LNModalViewController.m
//  Block详解
//
//  Created by LN on 16/10/15.
//  Copyright © 2016年 Learning point. All rights reserved.
//

#import "LNModalViewController.h"

@interface LNModalViewController ()

@end

@implementation LNModalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    //--------------------------- <#我是分割线#> ------------------------------//
    //
    
    // 4.判断是否执行协议方法（是传值给ViewController）
//    if ([_delegate respondsToSelector:@selector(modalViewController:sendValue:)]) {
//        [_delegate modalViewController:self sendValue:@"白开水ln--我是delegate逆传"];
//    }
    
    
    
    //--------------------------- <#我是分割线#> ------------------------------//
    //
    
    // Block调用传值(传参),传值给ViewController
    if (_LNBlock) {
        _LNBlock(@"白开水ln--我是Block逆传");
    }
    
    
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
