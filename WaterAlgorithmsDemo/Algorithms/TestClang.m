//
//  TestClang.m
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2019/6/21.
//  Copyright © 2019 xuyanlan. All rights reserved.
//
//gcc -S 生成汇编
#import "TestClang.h"
static int numGlobel = 29;
@interface TestClang()
@property(nonatomic, assign) NSInteger value;
@end
@implementation TestClang
+ (void)testBlcok {
    //没有截获局部变量 __NSGlobalBlock__
    TestClang *test = [[TestClang alloc] init];
    test.value = 10;
    void(^block1)(void) = ^{
        NSLog(@"哈哈哈 %ld",(long)test.value);
    };
    NSLog(@" block1 = %@", block1);
    block1();
    //加上const则会为__NSGlobalBlock__ ，加上const的value存储在常量区
    //原因：只要block literal里没有引用栈或堆上的数据，那么这个block会自动变为__NSGlobalBlock__类型，这是编译器的优化
    //    const int value = 10;
    //截获了局部变量 __NSMallocBlock__
    static int numStatic = 12;
    
    int num = 10;
    
    __block int numBlock = 19;
    __block int numBlock2 = 30;
    __block int numBlockTest = 30;
    
    void(^block2)(void) = ^{
        
        NSLog(@"just a block === %d, numStatic = %d numGlobel = %d  numBlock=%d numBlock2=%d numBlockTest = %d", num,numStatic,numGlobel,numBlock,numBlock2,numBlockTest);
        
        NSLog(@"哈哈哈 %ld",(long)test.value);
    };
    num = 33;
    numStatic = 121;
    numGlobel = 129;
    numBlock = 22222;
    block2();
    NSLog(@"block2 = %@", block2);
}
@end
