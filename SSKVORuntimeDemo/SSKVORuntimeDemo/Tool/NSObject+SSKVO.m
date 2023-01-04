//
//  NSObject+SSKVO.m
//  SSKVORuntimeDemo
//
//   
//

#import "NSObject+SSKVO.h"
#import "SSObserverArray.h"
#import "SSObserverModel.h"
#import <objc/runtime.h>

@implementation NSObject (SSKVO)

+ (void)load
{
    [self switchMethod];
}

+ (void)switchMethod
{
    SEL removeSel = @selector(removeObserver:forKeyPath:);
    SEL myRemoveSel = @selector(removeDasen:forKeyPath:);
    SEL addSel = @selector(addObserver:forKeyPath:options:context:);
    SEL myaddSel = @selector(addDasen:forKeyPath:options:context:);
    
    Method systemRemoveMethod = class_getClassMethod([self class],removeSel);
    Method DasenRemoveMethod = class_getClassMethod([self class], myRemoveSel);
    Method systemAddMethod = class_getClassMethod([self class],addSel);
    Method DasenAddMethod = class_getClassMethod([self class], myaddSel);
    
    method_exchangeImplementations(systemRemoveMethod, DasenRemoveMethod);
    method_exchangeImplementations(systemAddMethod, DasenAddMethod);
}


//#pragma mark - 第一种方案，利用@try @catch
//// 交换后的方法
//- (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath
//{
//    @try {
//        [self removeDasen:observer forKeyPath:keyPath];
//    } @catch (NSException *exception) {}
//
//}
//
//// 交换后的方法
//- (void)addDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
//{
//    [self addDasen:observer forKeyPath:keyPath options:options context:context];
//
//}


#pragma mark - 第二种方案，利用私有属性
// 交换后的方法
- (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    NSMutableArray *Observers = [SSObserverArray sharedSSObserverArray];
    SSObserverModel *userPathData = [self observerKeyPath:keyPath];
    // 如果有该key值那么进行删除
    if (userPathData) {
        [Observers removeObject:userPathData];
        [self removeDasen:observer forKeyPath:keyPath];
    }
    return;
}

// 交换后的方法
- (void)addDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
    SSObserverModel *userPathData= [[SSObserverModel alloc]initWithObjc:self key:keyPath];
    NSMutableArray *Observers = [SSObserverArray sharedSSObserverArray];

         /// 拦截到对象和keyPath,给模型属性赋值。
    // 如果没有注册，那么才进行注册
    if (![self observerKeyPath:keyPath]) {
        // 2、把模型存入数组中。
        [Observers addObject:userPathData];
        [self addDasen:observer forKeyPath:keyPath options:options context:context];
    }

}

// 进行检索，判断是否已经存储了该Key值
- (SSObserverModel *)observerKeyPath:(NSString *)keyPath
{
    /**
     3、在存入之前做检索处理，判断是否已经存储了该Key值
     遍历数组，取出每一个模型，获取模型中的对象，
     首先判断对象是否一致，然后判断keypath是否一致。
         1.对于添加KVO监听：如果不一致那么就执行交换后addObserver方法。
         2.对于删除KVO监听: 如果一致那么我们就执行删除监听。
     */
    NSMutableArray *Observers = [SSObserverArray sharedSSObserverArray];
    for (SSObserverModel *data in Observers) {
        if ([data.objc isEqual:self] && [data.keyPath isEqualToString:keyPath]) {
            return data;
        }
    }
    return nil;
}

//#pragma mark - 第三种方案，利用私有属性
//// 交换后的方法
//- (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath
//{
//    if ([self observerKeyPath:keyPath observer:observer]) {
//        [self removeDasen:observer forKeyPath:keyPath];
//    }
//}
//
//// 交换后的方法
//- (void)addDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
//{
//    if (![self observerKeyPath:keyPath observer:observer]) {
//        [self addDasen:observer forKeyPath:keyPath options:options context:context];
//    }
//}
//

//// 进行检索获取Key
//- (BOOL)observerKeyPath:(NSString *)key observer:(id )observer
//{
//    id info = self.observationInfo;
//    NSArray *array = [info valueForKey:@"_observances"];
//    for (id objc in array) {
//        id Properties = [objc valueForKeyPath:@"_property"];
//        id newObserver = [objc valueForKeyPath:@"_observer"];
//
//        NSString *keyPath = [Properties valueForKeyPath:@"_keyPath"];
//        if ([key isEqualToString:keyPath] && [newObserver isEqual:observer]) {
//            return YES;
//        }
//    }
//    return NO;
//}


@end
