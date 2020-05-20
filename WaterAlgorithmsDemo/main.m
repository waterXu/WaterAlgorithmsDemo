//
//  main.m
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2018/5/8.
//  Copyright © 2018年 xuyanlan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Easy.h"
static int s_fatal_signals[] = {
    SIGABRT,
    SIGBUS,
    SIGFPE,
    SIGILL,
    SIGSEGV,
    SIGTRAP,
    SIGTERM,
    SIGKILL,
};

static int s_fatal_signal_num = sizeof(s_fatal_signals) / sizeof(s_fatal_signals[0]);

void UncaughtExceptionHandler(NSException *exception) {
    
    NSArray <NSString *>*callSymbols = [NSThread callStackSymbols];
    NSArray *exceptionArray = [exception callStackSymbols]; // 得到当前调用栈信息
    NSString *exceptionReason = [exception reason];       // 非常重要，就是崩溃的原因
    NSString *exceptionName = [exception name];           // 异常类型
}

void SignalHandler(int code)
{
    NSLog(@"signal handler = %d",code);
}

void InitCrashReport()
{
    // 系统错误信号捕获
    for (int i = 0; i < s_fatal_signal_num; ++i) {
        signal(s_fatal_signals[i], SignalHandler);
    }
    
    //oc 未捕获异常的捕获
    NSSetUncaughtExceptionHandler(&UncaughtExceptionHandler);
}


int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        Easy *easy = [[Easy alloc] init];
//    }
    @autoreleasepool {
        InitCrashReport();
        NSLog(@"-----> runloop is %p",[NSRunLoop currentRunLoop]);//主线程的runloop

        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
