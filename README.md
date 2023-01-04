# Runtime 实现防止 KV O的重复添加或删除

## **KVO**（`KeyValueObersver`）键值监听-实现原理

**KVO**（`KeyValueObersver`）即键值监听，是观察者设计模式的又一实现，
 系统使用了isa混写（isa-swizzling）来实现KVO。
利用一个`key`来找到某个属性并监听其属性值得改变，当该属性发生变化时，
会自动的通知观察者，也是一种典型的观察者模式。

    1.使用步骤：
        注册观察者：addObserver:forKeyPath:options:context:
        实现观察者方法：observeValueForKeyPath:ofObject:change:context:
        移除观察者：removeObserver:forKeyPath:(对象销毁，必须移除观察者)

### KVO 实现原理

当一个类的属性被观察的时候，系统会通过runtime动态的创建一个该类的派生类，
并将类的isa指针指向了派生类，在派生类中重写被观察的属性的setter方法，
插入willChangeValueForKey和didChangeValueForKey方法。
当属性变化时会调用这两个方法，通知到外界属性的变化。
此外，派生类还重写了 dealloc 方法来释放资源。
 派生类还重写了class 方法，返回被观察属性的类

说明：
可以看到重写的 setter 方法，给属性赋值的前后分别调用了两个方法。
```objc
- (void)willChangeValueForKey:(NSString *)key;
- (void)didChangeValueForKey:(NSString *)key;
```
而`- (void)didChangeValueForKey:(NSString *)key;`会调用
```objc
- (void)observeValueForKeyPath:(nullable NSString *)keyPath 
ofObject:(nullable id)object change:(nullable NSDictionary<NSString*, id> *)change context:(nullable void *)context;
```

键值观察通知依赖于NSObject的两个方法：`willChangeValueForKey:` 和 `didChangevlueForKey:`；
在一个被观察属性发生改变之前（即调用原来的setter方法），
`willChangeValueForKey:` 先被调用会记录旧的值。
而当改变发生后，`didChangeValueForKey:` 会被调用，而`didChangeValueForKey:`方法内部又会调用
`observeValueForKeyPath:ofObject:change:context:`(在监听回调方法中监听属性的变化) 也会被调用。

 ### KVO 手动发送通知机制

手动调用 `willChangeValueForKey`和`didChangeValueForKey`两个方法，
就可以实现在不改变属性值的情况下手动触发KVO，并且这两个方法缺一不可。

```objc

// 直接修改成员变量,手动的调用上下两个方法,使其具有通知机制
[self willChangeValueForKey:@"name"];
student.name = @"KVO 手动发送通知机制";
[self didChangeValueForKey:@"name"];

```

补充：如果想实现手动通知，我们需要借助一个额外的方法（自动通知观察者密钥）

```objc
+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key
```
这个方法默认返回`YES`,用来标记 `Key` 指定的属性是否支持 `KVO`，
如果返回值为 `NO`，则需要我们手动更新。

 
 - 问题1：通过kvc设置value能否生效❓为什么❓
 `[obj setValue:@2 forKey:@"value"];`
  可以生效，内部调用了setter方法，在派生类中插入了`willChangeValueForKey` 和 `didChangeValueForKey`两个方法

 - 问题2：通过成员变量直接赋值value能否生效❓
 `[obj increase]`;
 不会生效，内部不会触发setter方法的调用
 
 - 通过KVC修改属性会触发KVO吗?
     >会触发KVO，即使没有 setter 方法也会触发.
     我们直接修改成员变量是不会触发 KVO 的,
     但是通过 KVC 却可以, 这说明 KVC 内部做了监听操作.

 
 - KVO只添加不移除，会有什么问题❓
     >KVO不移除监听会导致奔溃
     原因就是在我们添加观察者的时候，观察者和被观察者都不会被retain，
     然而在这些对象释放后，监听信息却还在，KVO做的处理就是直接让程序崩溃。
     解决办法:
     重写delloc，在delloc里面用removeObserver:forKeyPath：方法移除观察者
     类似的移除还有通知，注册通知也要移除相关的通知，否则，通知会发送多次。√
 
## 重复添加或重复删除KVO会怎么样❓

    如果添加多次KVO监听这个时候我们就会接受到多次监听。如果删除多次KVO程序就会造成crash。

    核心 : 利用runtime实现方法交换，进行拦截add和remove进行操作。

    方案一 ：利用 @try @catch
    方案二 ：利用 模型数组 进行存储记录
    方案三 ：利用 observationInfo 里私有属性

    方案一只能针对多次删除KVO的处理，原理就是try catch可以捕获异常，不让程序catch，
    实现了防止多次删除KVO。
        需要每次removeObserver的时候，就加上去一个@try @catch
        有个简单的方法：给NSObject 增加一个分类，然后利用Run time 交换系统的 
        removeObserver方法，在里面添加 @try @catch。

    方案二利用 模型数组 进行存储记录:
        步骤：
        1.定义一个模型用来存储哪个对象执行了addObserver、监听的KeyPath是什么。
        2.利用runtime 对注册观察者方法和移除观察者方法做方法交换，在方法内部，
        拦截到对象和keyPath,给模型属性赋值。
            addObserver:forKeyPath:options:context: 
            removeObserver:forKeyPath:
        2.把模型存入数组中。
        3.在存入之前做检索处理，判断是否已经存储了该Key值
        遍历数组，取出每一个模型，获取模型中的对象，
        首先判断对象是否一致，然后判断keypath是否一致。
            1.对于添加KVO监听：如果不一致那么就执行交换后addObserver方法。
            2.对于删除KVO监听: 如果一致那么我们就执行删除监听。

        
    方案三 利用 observationInfo 里私有属性
    1.通过私有属性直接拿到当前对象所监听的keyPath，和observer
    2.判断keyPath是否有无，和observer是否对应一致，来实现防止多次重复添加和删除KVO监听。
    3.首先拿出_observances数组，然后遍历拿出里面_property对象里面的
    NSKeyValueProperty下的一个keyPath，然后进行判断需要删除或添加的keyPath是否一致，
    然后再次判断传递过来的observer和监听的对象是否一致，然后分别进行处理就行了。
        说明：
        有一个_observances数组用来存储NSKeyValueObservance对象，
        NSKeyValueObservance属性简单说明
        _observer属性：里面放的是监听属性的通知者，
        也就是当属性改变的时候让哪个对象执行observeValueForKeyPath的对象。
    _property 里面的NSKeyValueProperty，NSKeyValueProperty存储的有keyPath


### pragma mark - KVO拦截

- 使用场景

底层修改判断KVO，可实现防止忘记移除KVO监听后，再次移除崩溃。防止多次添加KVO监听，造成的监听混乱

- 使用技术

核心 : 利用runtime实现方法交换，进行拦截add和remove进行操作。
方案一 ：利用 @try @catch
方案二 ：利用 模型数组 进行存储记录
方案二 ：利用 observationInfo 里私有属性

(1) 方案一（只能针对删除多次KVO的情况下）
利用 @try @catc

不得不说这种方法真是很Low，但是很简单就可以实现。
这种方法只能针对多次删除KVO的处理，原理就是try catch可以捕获异常，不让程序catch。这样就实现了防止多次删除KVO。

``` Swift

@try {
        [self.btn removeObserver:self forKeyPath:@"kkl"];
    } 
@catch (NSException *exception) {
        NSLog(@"多次删除了");
}

``` 

普通情况下，使用这种方法就需要每次removeObserver的时候，就加上去一个@try @catch
有个简单的方法：给NSObject 增加一个分类，然后利用Run time 交换系统的 removeObserver方法，在里面添加 @try @catch。

``` Swift
NSObject+DSKVO.m

#import "NSObject+SSKVO.h"
#import <objc/runtime.h>
@implementation NSObject (DSKVO)

+ (void)load
{
    [self switchMethod];
}

// 交换后的方法
- (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
    @try {
        [self removeDasen:observer forKeyPath:keyPath];
    } @catch (NSException *exception) {}
}

+ (void)switchMethod
{
    SEL removeSel = @selector(removeObserver:forKeyPath:);
    SEL myRemoveSel = @selector(removeDasen:forKeyPath:);

    Method systemRemoveMethod = class_getClassMethod([self class],removeSel);
    Method DasenRemoveMethod = class_getClassMethod([self class], myRemoveSel);

    method_exchangeImplementations(systemRemoveMethod, DasenRemoveMethod);
}

@end

``` 

(2) 方案二
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

``` Swift

NSObject+SSKVO.m


#import "NSObject+SSKVO.h"
#import "SSObserverArray.h"
#import "SSObserverModel.h"
#import <objc/runtime.h>


@implementation NSObject (DSKVO)

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



SSObserverModel 模型类文件有两个属性
@property (nonatomic, strong)id objc;
@property (nonatomic, copy)  NSString *keyPath;

SSObserverArray 类是一个单例数组
@implementation SSObserverArray
+ (instancetype)sharedSSObserverArray
{
    static id objc;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        objc = [NSMutableArray array];
    });
    return objc;
}

@end

```

方案三
利用 observationInfo 里私有属性

第一步 简单介绍下observationInfo属性
1，只要是继承与NSObject的对象都有observationInfo属性.
2，observationInfo是系统通过分类给NSObject增加的属性。
3，分类文件是NSKeyValueObserving.h这个文件
4，这个属性中存储有属性的监听者，通知者，还有监听的keyPath，等等KVO相关的属性。
5，observationInfo是一个void指针，指向一个包含所有观察者的一个标识信息对象，信息包含了每个监听的观察者,注册时设定的选项等。
`@property (nullable) void *observationInfo;`

6，observationInfo结构 (箭头所指是我们等下需要用到的地方)


第二步 实现方案思路
1，通过私有属性直接拿到当前对象所监听的keyPath，和observer
2，判断keyPath是否有无，和observer是否对应一直，来实现防止多次重复添加和删除KVO监听。

3，通过Dump Foundation.framework 的头文件，和直接xcode查看observationInfo的结构，发现有一个数组用来存储NSKeyValueObservance对象，
经过测试和调试，发现这个数组存储的需要监听的对象中，监听了几个属性，如果监听两个，数组中就是2个对象。
比如这是监听两个属性状态下的数组

4，NSKeyValueObservance属性简单说明
_observer属性：里面放的是监听属性的通知这，也就是当属性改变的时候让哪个对象执行observeValueForKeyPath的对象。
_property 里面的NSKeyValueProperty NSKeyValueProperty存储的有keyPath,其他属性我们用不到，暂时就不说了。

5，拿出keyPath
这时候思路就有了，首先拿出_observances数组，然后遍历拿出里面_property对象里面的NSKeyValueProperty下的一个keyPath，然后进行判断需要删除或添加的keyPath是否一致，然后再次判断传递过来的observer和监听的是否一致，然后分别进行处理就行了。

``` Swift

#import "NSObject+SSKVO.h"
#import <objc/runtime.h>

@implementation NSObject (DSKVO)

+ (void)load
{
    [self switchMethod];
}

// 交换后的方法
- (void)removeDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath
{
 if ([self observerKeyPath:keyPath observer:observer]) {
        [self removeDasen:observer forKeyPath:keyPath];
    }
}

// 交换后的方法
- (void)addDasen:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context
{
  if (![self observerKeyPath:keyPath observer:observer]) {
        [self addDasen:observer forKeyPath:keyPath options:options context:context];
    }
}

// 进行检索获取Key
- (BOOL)observerKeyPath:(NSString *)key observer:(id )observer
{
    id info = self.observationInfo;
    NSArray *array = [info valueForKey:@"_observances"];
    for (id objc in array) {
        id Properties = [objc valueForKeyPath:@"_property"];
        id newObserver = [objc valueForKeyPath:@"_observer"];
        
        NSString *keyPath = [Properties valueForKeyPath:@"_keyPath"];
        if ([key isEqualToString:keyPath] && [newObserver isEqual:observer]) {
            return YES;
        }
    }
    return NO;
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

```