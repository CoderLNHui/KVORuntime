
//
//  LNCacultorManager.m
//  Block详解
//
//  Created by LN on 16/10/15.
//  Copyright © 2016年 Learning point. All rights reserved.
//

#import "LNCacultorManager.h"

@implementation LNCacultorManager

- (void)cacultor:(NSInteger (^)(NSInteger))cacultorBlock
{
    //    cacultorBlock = ^(NSInteger result){
    //        result += 5;
    //        result += 6;
    //        result *= 2;
    //        return result;
    //    };
    
    if (cacultorBlock) {
        _result =  cacultorBlock(_result);
    }
}

@end
