//
//  LNOneBlockViewController.m
//  白开水ln（https://github.com/CustomPBWaters）
//
//  Created by 【Plain Boiled Water ln】 on Elegant programming16.
//  Copyright © Unauthorized shall（https://githubidea.github.io）not be reproduced reprinted.
//
//  @PBWLN_LICENSE_HEADER_END@
//

#import "LNOneBlockViewController.h"
#import "LNCellItem.h"

// 方式一：blockType:类型别名
typedef void (^BlockType)();


@interface LNOneBlockViewController ()<UITableViewDataSource,UITableViewDelegate>

// 方式二：block怎么声明,就如何定义成属性（推荐使用）
@property (nonatomic, strong) void(^myBlock)();

@property (nonatomic, strong) BlockType block1;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;


@end

@implementation LNOneBlockViewController

- (NSString *)controllerTitle {
    return @"Block基本使用";
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self test];
    [self test2];
    
    [self createItems];
    [self.view addSubview:self.tableView];

    
//    _block1 = ^{
//        NSLog(@"12222222");
//    };
//    
//    _myBlock = ^{
//        NSLog(@"23342344333");
//    };
    
}

//--------------------------- Block基本使用 ------------------------------//
//

- (void)test {
    /**
     1.Block声明:
     返回值(^Block变量名)(参数)
     void(^block)(); 最纯净的block,无返回值无参
     
     2.Block调用传值: block();
     
     3.Block接收值(参数值),保存代码
     modalVC.LNBlock = ^(NSString *value){
            
        NSLog(@"%@",value);
     };
     
     */
    
    //------------ block定义:三种方式 = ^(参数){}; ------------//
    //
    // 第一种
    void(^block1)() = ^(){
        NSLog(@"block1 %s, line = %d",__FUNCTION__,__LINE__);
    };
    block1();
    
    
    
    // 第二种: 如果没有参数,参数可以隐藏,如果有参数,定义的时候,必须要写参数,而且必须要有参数变量名
    void(^block2)(int) = ^(int a){
        NSLog(@"block2 %s, line = %d, a = %d",__FUNCTION__,__LINE__,a);
    };
    block2(10);
    
    
    
    // 第三种 block返回可以省略,不管有没有返回值,都可以省略
    int(^block3)() = ^int{
        NSLog(@"block3 %s, line = %d",__FUNCTION__,__LINE__);
        return 3;
    };
    block3();
    
    
    
    //--------------------------- block类型 ------------------------------//
    //
    
    // block类型:int(^)(NSString *)
    int(^block4)(NSString *) = ^(NSString *name){
        NSLog(@"block4 %s, line = %d",__FUNCTION__,__LINE__);
        return 2;
    };
    block4(@"11");
    
    
    // 无返回值,参数为两个字符串对象,变量名叫做LNBlock的Block
    void(^LNBlock)(NSString *x, int y) = ^(NSString *name,int age){
        NSLog(@"LNBlock %@-%d%s, line = %d",name,age, __FUNCTION__,__LINE__);

    };
    LNBlock(@"liunan",18);
    
    
    //--------------------------- block快捷方式 ------------------------------//
    //
    // block快捷方式 inline
//    <#returnType#>(^<#blockName#>)(<#parameterTypes#>) = ^(<#parameters#>) {
//        <#statements#>
//    };
}





//----------- 1.在一个方法中定义,在另外一个方法调用 ---------------//
//
- (void)test2 {
    void(^block)() = ^{
        NSLog(@"调用block");
    };
    _myBlock = block;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    // block调用:就去寻找保存代码,直接调用
//    _myBlock();
//    
//    _block1();
}




//----------- 2.在一个类中定义,在另外一个类中调用 小实力---------------//
//
- (void)createItems {
    
    //--------------------------- 创建模型 ------------------------------//
    /**
     item1.LNblock = ^{
         // Block保存代码
     };
     */
    LNCellItem *item1 = [LNCellItem itemWithTitle:@"简书"];
    LNCellItem *item2 = [LNCellItem itemWithTitle:@"GitHub"];
    LNCellItem *item3 = [LNCellItem itemWithTitle:@"Blog"];
   
    item1.LNBlock = ^{
        NSLog(@"白开水ln--简书");
    };
    item2.LNBlock = ^{
        NSLog(@"白开水ln--GitHub");
    };
    item3.LNBlock = ^{
        NSLog(@"白开水ln--Blog");
    };
    
    _items = @[item1,item2,item3];
}


#pragma mark ------------------
#pragma mark - tableViewDataSource Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}


#pragma mark ------------------
#pragma mark - tableViewDataSource Delegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    LNCellItem *item = self.items[indexPath.row];
    
    cell.textLabel.text = item.title;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    LNCellItem *item = self.items[indexPath.row];
    
    /** 点击每个Cell把要做的事情(代码)保存到模型中 */

    // 这里严谨点,要加上判断
    if (item.LNBlock) {
        item.LNBlock(); // Block调用
    }
    
    //--------------------------- 笨的方式二 ------------------------------//
    // 代码可读性很差
    
//    if (indexPath.row == 0) {
//        NSLog(@"白开水ln--简书");
//    } else if (indexPath.row == 1) {
//        NSLog(@"白开水ln--GitHub");
//    } else if (indexPath.row == 2) {
//        NSLog(@"白开水ln--Blog");
//    }
   
}







@end































