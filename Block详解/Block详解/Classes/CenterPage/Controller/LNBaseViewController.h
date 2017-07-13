//
//  LNBaseViewController.h
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//  基类

#import <UIKit/UIKit.h>
#import "LNOperateBtn.h"

@interface LNBaseViewController : UIViewController
@property (nonatomic, strong) UIImageView *imageV;

/**
 当前Controller的标题
 */
-(NSString *)controllerTitle;


/**
 初始化View
 */
-(void)initView;


/**
 按钮操作区的数组元素
 */
-(NSArray *)operateTitleArray;


/**
 每个按钮的点击事件
 */
-(void)btnClick : (UIButton *)btn;


- (void)showWithResult:(NSString *)result;
@end
