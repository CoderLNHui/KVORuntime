//
//  LNCellItem.h
//  Block详解
//
//  Created by LN on 16/10/15.
//  Copyright © 2016年 Learning point. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNCellItem : NSObject

// 设计模型:控件需要展示什么内容,就定义什么属性
@property (nonatomic, strong) NSString *title;

// 提供构造方法
+ (instancetype)itemWithTitle:(NSString *)title;

// 保存每个cell做的事情
@property (nonatomic, strong) void(^LNBlock)();
// 提示:你要写什么，缺什么就补什么；开始不要想太多，就写个纯净的block

@end
