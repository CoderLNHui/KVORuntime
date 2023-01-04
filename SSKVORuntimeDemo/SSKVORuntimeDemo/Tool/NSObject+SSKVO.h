//
//  NSObject+SSKVO.h
//  SSKVORuntimeDemo
//
//
//

/**
 原理：
 利用 模型数组 进行存储记录

 第一步 利用交换方法，拦截到需要的东西
 1，是在监听哪个对象。
 2，是在监听的keyPath是什么。

 第二步 存储思路
 1，我们需要一个模型用来存储
 哪个对象执行了addObserver、监听的KeyPath是什么。
 2，我们需要一个数组来存储这个模型。

 第三步 进行存储
 1，利用runtime 拦截到对象和keyPath,创建模型然后进行赋值模型相应的属性。
 2，然后存储进数组中去。

 第三步 存储之前的检索处理
 1，在存储之前，为了防止多次addObserver相同的属性，这个时候我们就可以，
 遍历数组，取出每个一个模型，然后取出模型中的对象，首先判断对象是否一致，
 然后判断keypath是否一致
 2，对于添加KVO监听：如果不一致那么就执行利用交换后方法执行addObserver方法。

 3，对于删除KVO监听: 如果一致那么我们就执行删除监听,否则不执行。
 
 */
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (SSKVO)

@end

NS_ASSUME_NONNULL_END
