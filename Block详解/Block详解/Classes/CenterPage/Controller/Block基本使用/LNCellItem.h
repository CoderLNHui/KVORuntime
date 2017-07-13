//
//  LNCellItem.h
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
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
