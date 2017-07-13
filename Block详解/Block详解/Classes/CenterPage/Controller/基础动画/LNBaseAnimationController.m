//
//  LNBaseAnimationController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//
/**
 这个类是，演示【按钮操作区】示例代码。
 
 可以切换成这个类，查看具体效果
 */

#import "LNBaseAnimationController.h"

@interface LNBaseAnimationController ()

@end

@implementation LNBaseAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imageV];
}

- (NSString *)controllerTitle {
    return @"基础动画";
}

-(NSArray *)operateTitleArray {
    return [NSArray arrayWithObjects:@"位移",@"透明度",@"缩放",@"旋转",@"背景色", nil];
}

- (void)btnClick:(UIButton *)btn {
    switch (btn.tag) {
        case 0:
            [self positionAnimation];
            break;
            
        default:
            break;
    }
}


/**
 位移动画演示
 */
- (void)positionAnimation {
    // 1.创建动画对象(设置layer的属性值)
    CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"position"];
    // 2.设置属性值
    anima.fromValue = [NSValue valueWithCGPoint:CGPointMake(50, self.imageV.center.y)];
    anima.toValue = [NSValue valueWithCGPoint:CGPointMake(kScreenWidth- 50, self.imageV.center.y)];
    // 动画完成时,会自动删除动画
    //anima.removedOnCompletion = NO;
    // 设置让动画效果最后执行状态
    //anima.fillMode = kCAFillModeForwards;
    
    anima.duration = 1;
    anima.autoreverses = YES;
    
    // 3.添加动画
    [self.imageV.layer addAnimation:anima forKey:nil];
}

@end















