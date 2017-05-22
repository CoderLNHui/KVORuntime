//
//  CalculatorManager.m
//  Block详解
//
//  Created by LN on 16/10/15.
//  Copyright © 2016年 Learning point. All rights reserved.
//

#import "CalculatorManager.h"

@implementation CalculatorManager

- (CalculatorManager *(^)(int))add
{
    return ^(int value){
        _result += value;
        
        return self;
    };
}

//- (CalculatorManager *)add:(int)value
//{
//    _result += value;
//    
//    return self;
//}


@end
