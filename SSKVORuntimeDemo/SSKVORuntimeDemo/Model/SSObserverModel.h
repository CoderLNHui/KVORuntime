//
//  SSObserverModel.h
//  SSKVORuntimeDemo
//
//   
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///1.定义一个模型用来存储哪个对象执行了addObserver、监听的KeyPath是什么。

@interface SSObserverModel : NSObject

@property (nonatomic, strong) id objc;
@property (nonatomic, copy) NSString *keyPath;

- (instancetype)initWithObjc:(id)objc key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
