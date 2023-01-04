//
//  SSObserverArray.m
//  SSKVORuntimeDemo
//
//   
//

#import "SSObserverArray.h"

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
