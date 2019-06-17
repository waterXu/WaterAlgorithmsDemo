//
//  iOSTestViewController.m
//  WaterAlgorithmsDemo
//
//  Created by 唐崇 on 2019/6/15.
//  Copyright © 2019 xuyanlan. All rights reserved.
//

#import "iOSTestViewController.h"
#import <objc/runtime.h>
static char TestdynamicKey;
@interface iOSTestViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary *> *dataSoource;
//atomic VS noatomic
@property (atomic, assign) BOOL atomicVal;
@property (atomic, assign) BOOL noatomicVal;

//test dynamic
@property (nonatomic, copy) NSString *dynamicObj;

//test copy strong
@property (nonatomic, copy) NSString *stringCopy;
@property (nonatomic, copy) NSMutableString *stringMutableCopy;
@property (nonatomic, strong) NSString *stringStrong;

//test timer
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger time;

//test block
@property (nonatomic, copy) void(^block)(void); //如果成员变量没有被copy修饰或在赋值的时候没有进行copy，那么在使用这个block成员变量的时候就会崩溃。因为栈上的出了作用域就被释放掉了，copy操作可以将block从栈上copy到堆上
    //但是目前arc下block默认放在了堆上，所以用strong也可以
    // 如果用weak或着assign修饰会在block为__NSMallocBlock__类型时会造成野指针

@end

@implementation iOSTestViewController

@dynamic dynamicObj;

- (NSArray<NSDictionary *> *)dataSoource {
    if (_dataSoource == nil) {
        _dataSoource = @[
                         @{@"name":@"atomic VS noatomic",@"function":@"atomicVSnoatomic"},
                         @{@"name":@"TestCallTrack",@"function":@"TestCallTrack"},
                         @{@"name":@"processPrint",@"function":@"processPrint"},
                         @{@"name":@"copyAndMutableCopy",@"function":@"copyAndMutableCopy"},
                         @{@"name":@"testDynamic",@"function":@"testDynamic"},
                         @{@"name":@"test Perproty Copy VS Strong",@"function":@"testCopyStrong"},
                         @{@"name":@"test string Equal",@"function":@"testStringEqual"},
                         @{@"name":@"testRunloop",@"function":@"testRunloop"},
                         @{@"name":@"test scheduledTimerWithTimeInterval  problem",@"function":@"scheduledTimerWithTimeInterval"},
                         @{@"name":@"test frame bounds center",@"function":@"testFrame"},
                         @{@"name":@"test autoreleasepool",@"function":@"testAutoreleasepool"},
                         @{@"name":@"test block",@"function":@"testBlcok"},
                         @{@"name":@"test block property",@"function":@"testBlcokProperty"},
                         @{@"name":@"test block property invoke",@"function":@"testBlcokPropertyInvoke"},
                         ];
    }
    return _dataSoource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"iOS基础";
    self.navigationController.navigationBarHidden = NO;
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.tableView reloadData];
    
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




- (void)copyAndMutableCopy {
    
    //    NSException *exception = [NSException exceptionWithName: NSInvalidArgumentException reason: @"Testing" userInfo: nil];
    //    NSArray <NSString *>*callSymbols = [NSThread callStackSymbols];
    //    NSArray *exceptionArray = [exception callStackSymbols]; // 得到当前调用栈信息
    //    NSString *exceptionReason = [exception reason];       // 非常重要，就是崩溃的原因
    //    NSString *exceptionName = [exception name];           // 异常类型
    //
//    NSMutableString *s1 = [NSMutableString stringWithString:@"你好, 啊"];
//    NSMutableString *s2 = [NSMutableString stringWithFormat:@"%@, %@", @"你好", @"啊"];
//    if(s1.hash == s2.hash){
//        NSLog(@"----> hash = %ld",s1.hash);
//    }
    
    
    NSString *str1 = @"str1";
    NSString *copyStr = [str1 copy];
    //输出
    //str1=0x110006138 copyStr=0x110006138
    NSLog(@"str1 = %p copyStr = %p",str1,copyStr);
//    NSLog(@"str1=%p copyStr=%p",&str1,&copyStr);
    
    NSMutableString *str2 = [str1 mutableCopy];
    //输出
    //str1=0x110006138 str2=0x600000000a50
    NSLog(@"str1 = %p str2 = %p",str1,str2);
    
    
    NSMutableString *str3 = [[NSMutableString alloc] initWithString:@"str让字符多一些试试"];
    NSMutableString *str3Copy = [str3 copy];
    //输出
    //str3=0x6000028a29d0 str3Copy=0xfcf7c38114e6f157
    NSLog(@"str3 = %p str3Copy = %p",str3,str3Copy);
    NSLog(@"str3 = %p  str3Copy = %p",str3,str3Copy);
//    [str3Copy appendString:@"change"];//crash  str3Copy is NSString
    
    NSMutableString *str3MutableCopy = [str3 mutableCopy];
    NSLog(@"str3 = %p str3MutableCopy = %p ",str3,str3MutableCopy);
    [str3MutableCopy appendString:@"change"];//not crash str3MutableCopy is NSMutableString
    
    
    NSArray *array = @[@"array",@"array1"];
    NSMutableArray *array1 = [array mutableCopy];
    //输出  array=0x6000006d8ba0, array1=0x6000008d5950
    NSLog(@"array=%p, array1=%p",array,array1);
    [array1 addObject:@"add"];//array1 为 NSMutableArray
    //数组中的对象没变，单层拷贝
    for(id obj in array){
        NSLog(@"%p",obj);
    }
    for(id obj in array1){
        NSLog(@"%p",obj);
    }
    
    NSMutableArray *array2 = [array1 copy];
    //输出  array=0x6000006d8ba0, array1=0x6000008d5950
    NSLog(@"array1=%p, array2=%p",array1,array2);
    //数组中的对象没变，单层拷贝
    for(id obj in array1){
        NSLog(@"--->> 111 %p",obj);
    }
    for(id obj in array2){
        NSLog(@"--->> 2222 %p",obj);
    }
    
    NSArray *array3 = [array2 copy];
    //输出  array=0x6000006d8ba0, array1=0x6000008d5950
    NSLog(@"array2=%p, array3=%p",array2,array3);
    //数组中的对象没变，单层拷贝
    for(id obj in array2){
        NSLog(@"--->> 222 %p",obj);
    }
    for(id obj in array3){
        NSLog(@"--->> 333 %p",obj);
    }
    
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


- (void)TestCallTrack {
    //    [[NSException exceptionWithName:@"Database already in pool" reason:@"The FMDatabase being put back into the pool is already present in the pool" userInfo:nil] raise];
}

- (void)atomicVSnoatomic {
    __weak typeof(self) weakSelf = self;
    //test noatomic 线程不安全
    dispatch_queue_t queueA = dispatch_queue_create("ququeA", DISPATCH_QUEUE_CONCURRENT);
    
    for (int i=0;i<10 ;i++) {
        dispatch_async(queueA, ^{
            weakSelf.noatomicVal = YES;
            NSLog(@"----> A [NSRunLoop currentRunLoop] = %p",[NSRunLoop currentRunLoop]);
            NSLog(@"----> A [NSThread currentThread] = %p",[NSThread currentThread]);
        });
    }
    
    dispatch_queue_t ququeB = dispatch_queue_create("ququeB", DISPATCH_QUEUE_CONCURRENT);
    for (int i=0;i<10 ;i++) {
        dispatch_async(ququeB, ^{
            weakSelf.noatomicVal = NO;
            NSLog(@"----> B [NSRunLoop currentRunLoop] = %p",[NSRunLoop currentRunLoop]);
            NSLog(@"----> B [NSThread currentThread] = %p",[NSThread currentThread]);
        });
    }
    
    dispatch_queue_t ququeC = dispatch_queue_create("ququeC", DISPATCH_QUEUE_CONCURRENT);
    for (int i=0;i<10 ;i++) {
        dispatch_async(ququeC, ^{
            NSLog(@"----> C [NSThread currentThread] = %p",[NSThread currentThread]);
            NSLog(@"----> C [NSRunLoop currentRunLoop] = %p \n\r noatomicVal = %@",[NSRunLoop currentRunLoop],weakSelf.noatomicVal ? @"YES" : @"NO");
        });
    }
}

- (void)testDynamic {
//    _dynamicObj = @"testDynamic";//编译不通过  Use of undeclared identifier '_dynamicObj'
    self.dynamicObj = @"testString";//编译通过，不实现下面getter和setter方法则会运行时崩溃  -[iOSTestViewController setDynamicObj:]: unrecognized selector sent to instance 0x7fa18141eba0
    NSLog(@"---> dynamicObj = %@",self.dynamicObj);
}

- (void)setDynamicObj:(NSString *)dynamicObj {
    [self willChangeValueForKey:@"dynamicObj"];
    objc_setAssociatedObject(self, &TestdynamicKey, dynamicObj, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self didChangeValueForKey:@"dynamicObj"];
}

- (NSString *)dynamicObj {
    return objc_getAssociatedObject(self, &TestdynamicKey);
}


- (void)testCopyStrong {
    NSMutableString *string = [NSMutableString stringWithString: @"哈哈哈111"];
    self.stringCopy = string;
    self.stringStrong = string;
    [string appendString:@"我悄悄改变了"];
    //输出
    //----> stringCopy = 哈哈哈111， stringStrong = 哈哈哈111我悄悄改变了
    NSLog(@"----> stringCopy = %@， stringStrong = %@",self.stringCopy,self.stringStrong);
    string = [NSMutableString stringWithString: @"我悄悄改变了"];
    //输出
    //----> stringCopy = 哈哈哈111， stringStrong = 哈哈哈111我悄悄改变了
    NSLog(@"----> stringCopy = %@， stringStrong = %@",self.stringCopy,self.stringStrong);
    //运行时实例化后 stringMutableCopy 为不可变的NSString，可断点查看
    self.stringMutableCopy = [NSMutableString stringWithString: @"string mutable 2222 "];
    [self.stringMutableCopy appendString:@"change val"]; //crash Attempt to mutate immutable object with appendString:
    NSLog(@"----> stringMutableCopy = %@",self.stringMutableCopy);
}


- (void)testStringEqual {
    //    == 这个符号判断的不是这两个值是否相等，而是这两个指针是否指向同一个对象。如果要判断两个 NSString 是否值相同，平时开发应该用 isEqualToString 这个方法。
    //    上面的代码中，两个指针指向不同的对象，尽管它们的值相同。但是 iOS 的编译器优化了内存分配，当两个指针指向两个值一样的 NSString 时，两者指向同一个内存地址。所以这道题会进入 if 的判断，打印出 "Equal" 字符串。
    
    //断点查看
    //通过快捷方式生成的字符串，不管长度多大都是 __NSCFConstantString  类型，存储在数据区
    NSString *firstStr = @"helloworld";
    NSString *secondStr = @"helloworld";
    
    if (firstStr == secondStr) {
        NSLog(@"Equal");
    } else {
        NSLog(@"Not Equal");
    }
    
    //断点查看
    //firstStr1和secondStr2为 __NSCFString 类型，存储在堆区，具有不同的对象，指向的不是同一个对象
    NSString *firstStr1 = [NSString stringWithFormat:@"%@", @"helloworld"];
    NSString *secondStr1 = [NSString stringWithFormat:@"%@", @"helloworld"];
    
    if (firstStr1 == secondStr1) {
        NSLog(@"---> 11111 Equal");
    } else {
        NSLog(@"---> 11111 Not Equal");
    }
    
    //断点查看
    //firstStr1和secondStr2为 NSTaggedPointerString，存储在栈区，指向同一个对象
    NSString *firstStr2 = [NSString stringWithFormat:@"%@", @"ssssssssss"];
    NSString *secondStr2 = [NSString stringWithFormat:@"%@", @"ssssssssss"];
    
    if (firstStr2 == secondStr2) {
        NSLog(@"---> 22222 Equal");
    } else {
        NSLog(@"---> 22222 Not Equal");
    }
    
    
    
//    NSTaggedPointerString(栈区)      ---> NSString
//    __NSCFConstantString(数据常量区)  ---> __NSCFString (堆区) --->NSMutableString --->NSString
}

- (void)testRunloop {
    //监听runloop
    CFRunLoopObserverContext context = {0,(__bridge void*)self,NULL,NULL};
    CFRunLoopObserverRef runLoopObserver = CFRunLoopObserverCreate(kCFAllocatorDefault,kCFRunLoopAllActivities,YES,0,&runLoopObserverCallBack,&context);
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), runLoopObserver, kCFRunLoopCommonModes);
    
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handlTimerRunloop) userInfo:nil repeats:NO];
    
}
- (void)handlTimerRunloop {
    
}

- (void)scheduledTimerWithTimeInterval{
    if(self.timer) {
        return;
    }
    
    [[NSThread currentThread] setName:@"timerMainThread"]; //当前线程就是主线程
    self.time = 0;
    //使用scheduledTimerWithTimeInterval的方式的timer。当用户滚动列表时，timer会暂停
    //原因。当用户滚动列表时，runloop 的 mode 由原来的 Default 模式切换到了 Event Tracking 模式，timer 原来好好的运行在 Default 模式中，被关闭后自然就停止工作了。
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(handlTimer:) userInfo:nil repeats:NO];
    //使用指定runloop来执行timer，不在主线程的runloop中run
    // 方法1
    //可以将 timer 分别加入到这两个 mode
    [[NSRunLoop currentRunLoop] addTimer: self.timer forMode:UITrackingRunLoopMode];
    // 方法2
    // 将 timer 加入到 NSRunloopCommonModes 中。
//    [[NSRunLoop currentRunLoop] addTimer: self.timer forMode:NSRunLoopCommonModes];
    
    // 方法3
    // 将 timer 放到另一个线程中，然后开启另一个线程的 runloop，这样可以保证与主线程互不干扰，而现在主线程正在处理页面滑动
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(handlTimer2:) userInfo:nil repeats:YES];
//        [[NSThread currentThread] setName:@"timerThread"];
//        [[NSRunLoop currentRunLoop] run];
//    });
}

- (void)handlTimer:(NSTimer *)theTimer {
    self.time ++;
    NSLog(@"---------> %ld",self.time);
    NSLog(@"-----> runloop is %p",[NSRunLoop currentRunLoop]);
    //不拖动列表时为kCFRunLoopDefaultMode 拖动时为UITrackingRunLoopMode
    NSLog(@"-----> runloop mode is %@", [[NSRunLoop currentRunLoop] currentMode]);
    NSLog(@"-----> current theard name is %@", [[NSThread currentThread] name]);
    NSLog(@"-----> main theard name is %@", [[NSThread mainThread] name]);
    
}

- (void)handlTimer2:(NSTimer *)theTimer {
    self.time ++;
    NSLog(@"---------> %ld",self.time);
    NSLog(@"-----> runloop is %p",[NSRunLoop currentRunLoop]);
    //kCFRunLoopDefaultMode
    NSLog(@"-----> runloop mode is %@", [[NSRunLoop currentRunLoop] currentMode]);
    NSLog(@"-----> current theard name is %@", [[NSThread currentThread] name]);
    
}


- (void)testFrame {
    UIView *viewA = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 500, 400)];
    viewA.backgroundColor = [UIColor redColor];
    [self.view addSubview:viewA];
    UIView *viewb = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 200, 250)];
    viewb.backgroundColor = [UIColor yellowColor];
    [viewA addSubview:viewb];
    NSLog(@"viewb frame is %@",NSStringFromCGRect(viewb.frame));
    NSLog(@"viewb bounds is %@",NSStringFromCGRect(viewb.bounds));
    NSLog(@"viewb center is %@",NSStringFromCGPoint(viewb.center));
}

- (void)testAutoreleasepool {
    [self test1];
    [self test2];
}

- (void)test1 {
    
    NSLog(@"test1 begin!");
    for (int i = 0; i < 10e5 * 2; i++) {
        @autoreleasepool {
            NSString *str = [NSString stringWithFormat:@"hi + %d", i];
        }
    }
    NSLog(@"test1 finished!");
}

- (void)test2 {
    
    NSLog(@"test2 begin!");
    for (int i = 0; i < 10e5 * 2; i++) {
        @autoreleasepool {
            NSString *str = [NSString stringWithFormat:@"hi + %d", i];
        }
    }
    NSLog(@"test2 finished!");
}

- (void)testBlcok {
    //没有截获局部变量 __NSGlobalBlock__
    void(^blockA)(void) = ^{
        NSLog(@"just a block");
            };
    NSLog(@"%@", blockA);
    //加上const则会为__NSGlobalBlock__ ，加上const的value存储在常量区
    //原因：只要block literal里没有引用栈或堆上的数据，那么这个block会自动变为__NSGlobalBlock__类型，这是编译器的优化
//    const int value = 10;
    //截获了局部变量
    int value = 10;
        void(^blockB)(void) = ^{
        
        NSLog(@"just a block === %d", value);
            };
    NSLog(@"%@", blockB);
    //一般并不会这么使用
    //加上const value 则会为__NSGlobalBlock__
    // __NSStackBlock__
    void(^ __weak blockC)() = ^{
        NSLog(@"just a block === %d", value);
            };
    
    NSLog(@"%@", blockC);
}


- (void)testBlcokProperty {
    
    int value = 10;
        void(^blockTest)(void) = ^{
        
//        NSLog(@"just a globle block ");//不使用value则是globleblock，一直不会释放，就算使用weak或者assign也不会有野指针
        NSLog(@"just a block === %d", value);
            };
    NSLog(@"%@", blockTest);
    _block = blockTest;
    NSLog(@"%@", _block);
}

- (void)testBlcokPropertyInvoke {
    _block();
}


static void runLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    switch (activity) {
        case kCFRunLoopEntry:
            NSLog(@"进入RunLoop");
            break;
        case kCFRunLoopBeforeTimers:
            NSLog(@"即将处理Timer事件");
            break;
        case kCFRunLoopBeforeSources:
            NSLog(@"即将处理Source事件");
            break;
        case kCFRunLoopBeforeWaiting:
            NSLog(@"即将休眠");
            break;
        case kCFRunLoopAfterWaiting:
            NSLog(@"被唤醒");
            break;
        case kCFRunLoopExit:
            NSLog(@"退出RunLoop");
            break;
        default:
            break;
    }
    
    //    NSLog(@"-----> activity is %lu", activity);
//    NSLog(@"-----> runloop mode is %@", [[NSRunLoop currentRunLoop] currentMode]);
}


@end

