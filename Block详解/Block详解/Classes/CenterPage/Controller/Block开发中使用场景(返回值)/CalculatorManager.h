//
//  CalculatorManager.h
//  Block详解
//
//  Created by LN on 16/10/15.
//  Copyright © 2016年 Learning point. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorManager : NSObject

@property (nonatomic, assign) int result;



//- (CalculatorManager *)add:(int)value;

- (CalculatorManager *(^)(int))add;

@end
