//
//  LNFiveViewController.m
//  Block详解
//
//  Created by LN on 16/10/15.
//  Copyright © 2016年 Learning point. All rights reserved.
//

#import "LNFiveViewController.h"
#import "ModalViewController.h"

@interface LNFiveViewController ()

@end

@implementation LNFiveViewController


- (NSString *)controllerTitle {
    return @"Block循环引用";
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    ModalViewController *modalVc = [[ModalViewController alloc] init];
    modalVc.view.backgroundColor = [UIColor greenColor];
    
    [self presentViewController:modalVc animated:YES completion:nil];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


@end

















