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
                         @{@"name":@"TestCallTrack",@"function":@"TestCallTrack"},
                         @{@"name":@"processPrint",@"function":@"processPrint"},
                         @{@"name":@"copyAndMutableCopy",@"function":@"copyAndMutableCopy"},
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
    
}



- (void)copyAndMutableCopy {
    
//    NSException *exception = [NSException exceptionWithName: NSInvalidArgumentException reason: @"Testing" userInfo: nil];
//    NSArray <NSString *>*callSymbols = [NSThread callStackSymbols];
//    NSArray *exceptionArray = [exception callStackSymbols]; // 得到当前调用栈信息
//    NSString *exceptionReason = [exception reason];       // 非常重要，就是崩溃的原因
//    NSString *exceptionName = [exception name];           // 异常类型
//    
    NSMutableString *s1 = [NSMutableString stringWithString:@"大风, 哥"];
    NSMutableString *s2 = [NSMutableString stringWithFormat:@"%@, %@", @"大风", @"哥"];
    if(s1.hash == s2.hash){
        NSLog(@"----> hash = %ld",s1.hash);
    }
    NSString*str1=@"str1";
    NSMutableString*str2=[str1 mutableCopy];
    NSLog(@"str1=%p str2=%p",str1,str2);
    NSMutableString*str3=[[NSMutableString alloc] initWithString:@"str1"];;
    NSMutableString*str4=[str1 mutableCopy];
    NSLog(@"str3=%p str4=%p",str3,str4);
    NSMutableString*str5=[str1 copy];
    // 因为NSString对象本身就不可变，所以并没产生新的对象，而是返回对象本身，但是引用计数加1
    NSLog(@"str1=%p str5=%p",str1,str5);
    
    NSMutableString*str6=[str3 copy];
    //从打印结果可以看到两个地址不一样，说明发生的是深拷贝。
    NSLog(@"str3=%p str6=%p",str3,str6);
    
    
    NSArray *array=@[@"array",@"array1"];
    NSMutableArray *array1=[array mutableCopy];
    NSLog(@"array=%p, array1=%p",array,array1);
    //数组中的对象没变，单层拷贝
    for(id obj in array){
       NSLog(@"%p",obj);
    }
    for(id obj in array1){
        NSLog(@"%p",obj);
    }
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

    
- (void)processPrint{
    NSLog(@"----------- 111111111111111111---------------");
    NSProcessInfo * pInfo = [NSProcessInfo processInfo];//创建进程信息对象
    NSLog(@"进程标识 ： %d",[pInfo processIdentifier]);//获取进程标识
    NSLog(@"进程名称 ： %@",[pInfo processName]);
    NSLog(@"主机名称 ： %@",[pInfo hostName]);
    NSLog(@"系统版本信息 ： %@",[pInfo operatingSystemVersionString]);
    NSLog(@"进程环境 ： %@",[pInfo environment]);
    
    NSProcessInfo *processInfo = [NSProcessInfo processInfo];
    NSLog(@"hostName:%@",processInfo.hostName);
    processInfo.processName = @"custom_process_name";
    NSLog(@"processName:%@",processInfo.processName);
    NSLog(@"processIdentifier:%d",processInfo.processIdentifier);
    NSLog(@"globallyUniqueString:%@",processInfo.globallyUniqueString);
    NSLog(@"operatingSystemVersionString:%@",processInfo.operatingSystemVersionString);
    NSLog(@"operatingSystemVersion.majorVersion:%ld",processInfo.operatingSystemVersion.majorVersion);
    NSLog(@"operatingSystemVersion.minorVersion:%ld",processInfo.operatingSystemVersion.minorVersion);
    NSLog(@"operatingSystemVersion.patchVersion:%ld",processInfo.operatingSystemVersion.patchVersion);
    NSLog(@"systemUptime:%f",processInfo.systemUptime);
    if (@available(iOS 9.0, *)) {
        NSLog(@"lowPowerModeEnabled:%d",processInfo.lowPowerModeEnabled);
    } else {
        // Fallback on earlier versions
    }
    NSLog(@"environment:%@",processInfo.environment);
    NSLog(@"arguments:%@",processInfo.arguments);

}

- (void)easy {
    EasyViewController *easyVC = [[EasyViewController alloc] init];
    [self.navigationController pushViewController:easyVC animated:YES];
}

- (void)TestCallTrack {
//    [[NSException exceptionWithName:@"Database already in pool" reason:@"The FMDatabase being put back into the pool is already present in the pool" userInfo:nil] raise];
}

- (void)medium {
    MediumViewController *mediumVC = [[MediumViewController alloc] init];
    [self.navigationController pushViewController:mediumVC animated:YES];
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
