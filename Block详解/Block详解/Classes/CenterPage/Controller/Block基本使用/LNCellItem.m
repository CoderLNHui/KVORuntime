//
//  LNCellItem.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "LNCellItem.h"

@implementation LNCellItem

+ (instancetype)itemWithTitle:(NSString *)title {
    LNCellItem *item = [[LNCellItem alloc] init];
    
    item.title = title;
    
    return item;
}

@end
