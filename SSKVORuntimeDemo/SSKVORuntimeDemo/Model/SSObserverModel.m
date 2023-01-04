//
//  SSObserverModel.m
//  SSKVORuntimeDemo
//
//   
//

#import "SSObserverModel.h"

@implementation SSObserverModel

- (instancetype)initWithObjc:(id)objc key:(NSString *)key
{
    if (self = [super init]) {
        self.objc = objc;
        self.keyPath = key;
    }
    return self;
}

@end
