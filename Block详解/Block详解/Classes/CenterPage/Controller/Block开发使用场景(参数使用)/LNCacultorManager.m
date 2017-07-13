//
//  LNCacultorManager.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
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
