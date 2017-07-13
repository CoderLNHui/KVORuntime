//
//  LNModalViewController.h
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://custompbwaters.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import <UIKit/UIKit.h>


//--------------------------- 代理传值 ------------------------------//
//
/**
#import <UIKit/UIKit.h>
 
// 1.定义代理名(先声明)
@class LNModalViewController;
@protocol LNModalViewControllerDelegate <NSObject>

// 2.定义协议(想要代理做什么事情)
- (void)modalViewController:(LNModalViewController *)modalVc sendValue:(NSString *)value;

@end

@interface LNModalViewController : UIViewController

// 3.定义遵守协议的代理
@property (nonatomic, strong) id <LNModalViewControllerDelegate>delegate;
 
 
 */


//--------------------------- Block传值 ------------------------------//
//

@interface LNModalViewController : UIViewController


// 纯洁的block
@property (nonatomic, strong) void(^LNBlock)(NSString *value);























@end
