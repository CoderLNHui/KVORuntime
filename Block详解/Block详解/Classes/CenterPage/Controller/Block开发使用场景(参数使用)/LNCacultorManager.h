//
//  LNCacultorManager.h
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import <Foundation/Foundation.h>

@interface LNCacultorManager : NSObject

//  LNCacultorManager.h
/** 保存计算的值 */
@property (nonatomic, assign) NSInteger result;

/** 计算 */
- (void)cacultor:(NSInteger(^)(NSInteger result))cacultorBlock;

@end
