
//
//  LNCellItem.m
//  Block详解
//
//  Created by LN on 16/10/15.
//  Copyright © 2016年 Learning point. All rights reserved.
//

#import "LNCellItem.h"

@implementation LNCellItem

+ (instancetype)itemWithTitle:(NSString *)title {
    LNCellItem *item = [[LNCellItem alloc] init];
    
    item.title = title;
    
    return item;
}

@end
