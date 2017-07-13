//
//  LNMainViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "LNMainViewController.h"

@interface LNMainViewController ()

@end

@implementation LNMainViewController

- (NSString *)controllerTitle {
    return @"Learning point";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageV];
}

@end
