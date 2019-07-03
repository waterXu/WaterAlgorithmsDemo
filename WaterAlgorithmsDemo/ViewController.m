//
//  ViewController.m
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2018/5/8.
//  Copyright © 2018年 xuyanlan. All rights reserved.
//

#import "ViewController.h"
#import "TestNavBarViewController.h"
#import "EasyViewController.h"
#import "MediumViewController.h"
#import <libkern/OSSpinLockDeprecated.h>
#import <os/lock.h>
#import <objc/runtime.h>
#import <objc/objc.h>
#import "iOSTestViewController.h"
#import "TestClang.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary *> *dataSoource;
@end

@implementation ViewController
- (NSArray<NSDictionary *> *)dataSoource {
    if (_dataSoource == nil) {
        _dataSoource = @[
                         @{@"name":@"最大公约数",@"function":@"testMaxDivisor"},
                         @{@"name":@"导航条切换",@"function":@"changeHideNav"},
                         @{@"name":@"print thread",@"function":@"printThread"},
                         @{@"name":@"Easy",@"function":@"easy"},
                         @{@"name":@"Medium",@"function":@"medium"},
                         @{@"name":@"iOS 基础",@"function":@"iOSTest"},
                         ];
    }
    return _dataSoource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"首页";
    self.navigationController.navigationBarHidden = NO;
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
//    [self printThread];
    [TestClang testBlcok];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.tableView reloadData];
    
}
- (void)printThread{
    //test
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"print 1, thread: \(Thread.current.isMainThread) = %@",NSThread.currentThread.isMainThread ? @"YES":@"NO");
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"print 2, thread: \(Thread.current.isMainThread) = %@",NSThread.currentThread.isMainThread ? @"YES":@"NO");
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"print 3, thread: \(Thread.current.isMainThread) = %@",NSThread.currentThread.isMainThread ? @"YES":@"NO");
    });
    dispatch_sync(dispatch_get_global_queue(0, 0), ^{
        NSLog(@"print 4, thread: \(Thread.current.isMainThread) = %@",NSThread.currentThread.isMainThread ? @"YES":@"NO");
    });
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        dispatch_sync(dispatch_get_global_queue(0, 0), ^{
            NSLog(@"print 5, thread: \(Thread.current.isMainThread) = %@ name = %@",NSThread.currentThread.isMainThread ? @"YES":@"NO",NSThread.currentThread.name);
        });
    });
}


- (void)easy {
    EasyViewController *easyVC = [[EasyViewController alloc] init];
    [self.navigationController pushViewController:easyVC animated:YES];
}


- (void)medium {
    MediumViewController *mediumVC = [[MediumViewController alloc] init];
    [self.navigationController pushViewController:mediumVC animated:YES];
}

- (void)iOSTest {
    iOSTestViewController *iosVC = [[iOSTestViewController alloc] init];
    [self.navigationController pushViewController:iosVC animated:YES];
}

- (void)changeHideNav {
    TestNavBarViewController *testNav = [[TestNavBarViewController alloc] init];
    [self.navigationController pushViewController:testNav animated:YES];
}

- (void)testMaxDivisor {
    NSLog(@"divisor is %d",[self maxDivisorP:3 q:10]);
}
//计算两个非负整数p和q的最大公约数，若q是0，则最大公约数为p,否则将p除以q的余数为r，则p和q的最大公约数为q的和r的最大公约数
- (int)maxDivisorP:(int)p q:(int) q {
    if(q == 0) {
        return p;
    }
    int r = p % q;
    NSLog(@"p is %d, q is %d",p,q);
    NSString *content = @"12222222222";
    BOOL re = [content writeToFile:@"/Users/xuyanlan/Desktop/text2.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    return [self maxDivisorP:q q:r];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSoource[indexPath.row][@"name"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *func = self.dataSoource[indexPath.row][@"function"];
    SEL function = NSSelectorFromString(func);
    [self performSelector:function];
}
@end

static void display_lock(dispatch_block_t block) {
    if (@available(iOS 10.0, *)) {
        static os_unfair_lock lockToken = OS_UNFAIR_LOCK_INIT;
        os_unfair_lock_lock(&lockToken);
        block();
        os_unfair_lock_unlock(&lockToken);
    } else {
        // Fallback on earlier versions
        static OSSpinLock lockToken = OS_SPINLOCK_INIT;
        OSSpinLockLock(&lockToken);
        block();
        OSSpinLockUnlock(&lockToken);
    }
}
