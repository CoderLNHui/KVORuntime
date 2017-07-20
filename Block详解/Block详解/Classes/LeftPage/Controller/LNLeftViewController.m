//
//  LNLeftViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "LNLeftViewController.h"
#import "LNBaseAnimationController.h"
#import "LNMainViewController.h"

#import "LNOneBlockViewController.h"
#import "LNTwoViewController.h"
#import "LNThreeViewController.h"
#import "LNFourViewController.h"
#import "LNFiveViewController.h"
#import "LNSixViewController.h"
#import "LNSevenViewController.h"
#import "LNEightViewController.h"



#define CellID @"cellID"
@interface LNLeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation LNLeftViewController

- (UITableView *)tableView
{
    if (!_tableView) {
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.view addSubview:self.tableView];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initData];
    
    // cell注册
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
}

- (void)initData {
    _dataArray = [NSArray arrayWithObjects:@"我是左侧菜单",@"Block基本使用",@"Block传值 & 代理传值",@"Block内存管理(MRC)",@"Block内存管理(ARC)",@"Block循环引用",@"Block变量传递",@"Block开发使用场景(参数使用)",@"Block开发中使用场景(返回值)", nil];
}


#pragma mark - 代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    
    cell.textLabel.text = self.dataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    SWRevealViewController *revealVC = self.revealViewController;
    UIViewController *viewController;
    switch (indexPath.row) {
        case 0:
            //viewController = [[LNBaseAnimationController alloc] init];
            viewController = [[LNMainViewController alloc] init];
            break;
        case 1:
            viewController = [[LNOneBlockViewController alloc] init];
            break;
        case 2:
            viewController = [[LNTwoViewController alloc] init];
            break;
        case 3:
            viewController = [[LNThreeViewController alloc] init];
            break;
        case 4:
            viewController = [[LNFourViewController alloc] init];
            break;
        case 5:
            viewController = [[LNFiveViewController alloc] init];
            break;
        case 6:
            viewController = [[LNSixViewController alloc] init];
            break;
        case 7:
            viewController = [[LNSevenViewController alloc] init];
            break;
        case 8:
            viewController = [[LNEightViewController alloc] init];
            break;
   
      
            
        default:
            break;
    }
    // 调用pushFrontViewController进行页面切换
    [revealVC pushFrontViewController:viewController animated:YES];
}
@end


















