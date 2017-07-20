//
//  LNFiveViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
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

















