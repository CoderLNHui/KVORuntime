//
//  LNCacultorManager.h
//  Block详解
//
//  Created by LN on 16/10/15.
//  Copyright © 2016年 Learning point. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LNCacultorManager : NSObject

//  LNCacultorManager.h
/** 保存计算的值 */
@property (nonatomic, assign) NSInteger result;

/** 计算 */
- (void)cacultor:(NSInteger(^)(NSInteger result))cacultorBlock;

@end
