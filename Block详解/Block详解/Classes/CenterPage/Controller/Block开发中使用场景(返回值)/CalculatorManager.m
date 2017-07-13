//
//  CalculatorManager.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
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
