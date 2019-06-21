//
//  Easy.m
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2019/5/8.
//  Copyright © 2019年 xuyanlan. All rights reserved.
//

#import "Easy.h"
#import "TreeNode.h"
#import <objc/runtime.h>
#import "Medium.h"

@implementation Easy
//测试类方法转发机制。
+ (BOOL)resolveClassMethod:(SEL)sel {
    NSString *selString = NSStringFromSelector(sel);
    NSLog(@"---> sel = %@",selString);
    Class metaClass = objc_getMetaClass(class_getName(self));
    SEL ovverideSel = @selector(repleaceFunc);
    Method ovverideMethod = class_getClassMethod(metaClass, ovverideSel);
    
    if(class_addMethod(metaClass, sel, method_getImplementation(ovverideMethod), method_getTypeEncoding(ovverideMethod))){
        return YES;
    }
    return [super resolveClassMethod:sel];
}

//测试实例方法消息转发
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"---> %s",__FUNCTION__);
    return NO;
}
//备用接收者
- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"---> %s",__FUNCTION__);
    return nil;
}
//重签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSLog(@"---> %s",__FUNCTION__);
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    if(!signature) {
        signature = [Medium instanceMethodSignatureForSelector:@selector(testSignature)];
    }
    return signature;
//    if ([NSStringFromSelector(aSelector) isEqualToString:@"plusOne"]) {
//        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
//    }
//    return [super methodSignatureForSelector:aSelector];
}
//anInvocation 来自methodSignatureForSelector
- (void)forwardInvocation:(NSInvocation *)anInvocation {
    NSLog(@"---> %s",__FUNCTION__); //不实现就不会报 doesNotRecognizeSelector
//    [anInvocation invoke];
    [Easy repleaceFunc];
}

+ (void)repleaceFunc{
    NSLog(@"---> %s",__FUNCTION__);
    NSArray *testArray = @[@1,@2,@3,@4,@9];
    NSArray *resultArray = [self plusOne:testArray];
    NSLog(@"%@ plus one = %@",testArray,resultArray);

    NSArray *testArray1 = @[@9,@9,@9,@9,@9];
    NSArray *resultArray1 = [self plusOne:testArray1];
    NSLog(@"%@ plus one = %@",testArray1,resultArray1);
}
#pragma mark - Math
//-------------Math------------
//+ (void)plusOne {
//    NSArray *testArray = @[@1,@2,@3,@4,@9];
//    NSArray *resultArray = [self plusOne:testArray];
//    NSLog(@"%@ plus one = %@",testArray,resultArray);
//
//    NSArray *testArray1 = @[@9,@9,@9,@9,@9];
//    NSArray *resultArray1 = [self plusOne:testArray1];
//    NSLog(@"%@ plus one = %@",testArray1,resultArray1);
//}
+ (NSArray *)plusOne:(NSArray * _Nonnull)numbers {
    NSMutableArray *numberMutable = [NSMutableArray arrayWithArray:numbers];
    NSInteger index = numbers.count - 1;
    while (index >= 0) {
        if([numbers[index] integerValue] < 9){
            numberMutable[index] = @([numbers[index] integerValue] + 1);
            return [numberMutable copy];
        }
        numberMutable[index] = @(0);
        index --;
    }
    [numberMutable insertObject:@1 atIndex:0];
    return [numberMutable copy];
}

+ (void)powerOfTwo {
    int number = 3;
    NSAssert(![self powerOfTwo:number],@"%d is not time two",number);
    
    int number1 = 16;
    NSAssert([self powerOfTwo:number1],@"%d is time two",number1);
    
    NSLog(@"power Of Two, success");
    
}
+ (BOOL)powerOfTwo:(int)number{
    if(number <= 0) {
        return NO;
    }
//    int cnt = 0;
//    while (number > 0) {
//        cnt += (number & 1);// &1 为1时则表示右移动后低位少了一个1，为0则表示右移出去的是0，最后计算出有多少个1，只有一个1则为2的次方
//        number >>= 1;
//    }
//    return cnt == 1;
    return (number & (number - 1)) == 0; //100000  & 011111 = 0
}

+ (void)powerOfThree {
    int number = 3;
    NSAssert([self powerOfThree:number],@"%d is time three",number);
    
    int number1 = 16;
    NSAssert(![self powerOfThree:number1],@"%d is not time three",number1);
    
    NSLog(@"power Of Three success");
}

+ (BOOL)powerOfThree:(int)number{
//    while (number && number % 3 == 0) {
//        number /= 3;
//    }
//    return number == 1;
    
//   return (number > 0 && 1162261467 % number == 0);//int 下 3的19次方为int下的3的倍数的最大值
    
//    最后还有一种巧妙的方法，利用对数的换底公式来做，高中学过的换底公式为logab = logcb / logca，那么如果n是3的倍数，则log3n一定是整数，我们利用换底公式可以写为log3n = log10n / log103，注意这里一定要用10为底数，不能用自然数或者2为底数，否则当n=243时会出错，原因请看这个帖子。现在问题就变成了判断log10n / log103是否为整数，在c++中判断数字a是否为整数，我们可以用 a - int(a) == 0 来判断，参见代码如下：
    float a = log10(number)/log10(3);
    return (number > 0 && (a == (int)a));
}

+ (void)powerOfFour {
    int number = 3;
    NSAssert(![self powerOfFour:number],@"%d is not time four",number);
    
    int number1 = 16;
    NSAssert([self powerOfFour:number1],@"%d is time four",number1);
    NSLog(@"power Of Four success");
}

+ (BOOL)powerOfFour:(int)number{
//  return  number > 0 && int(log10(number) / log10(4)) - log10(number) / log10(4) == 0;
//    return number > 0 && !(number & (number - 1)) && (number - 1) % 3 == 0; //满足2的次方，减一可以被三整除
    return number > 0 && (number & (number - 1)) == 0 && ((number & 0x55555555) == number);
}

//用了两个指针分别指向a和b的末尾，然后每次取出一个字符，转为数字，若无法取出字符则按0处理，然后定义进位carry，初始化为0，将三者加起来，对2取余即为当前位的数字，对2取商即为当前进位的值，记得最后还要判断下carry，如果为1的话，要在结果最前面加上一个1，参见代码如下
+ (void)addBinary{
    NSString *strA = @"1001";
    NSString *strB = @"101";
    NSString *res = [self addBinary:strA strB:strB];
    NSLog(@" %@ + %@ = %@",strA,strB,res);
}
+ (NSString *)addBinary:(NSString *)strA strB:(NSString *)strB {
    NSMutableString *res = [NSMutableString string];
    NSInteger i = strA.length - 1;
    NSInteger j = [strB length] - 1;
    int sum = 0;
    int carry = 0;
    while (i>=0 || j>=0 || carry > 0) {
        sum = carry;
        if(i>=0){
            sum += [[strA substringWithRange:NSMakeRange(i, 1)] intValue];
            i--;
        }
        if(j>=0){
            sum += [[strB substringWithRange:NSMakeRange(j, 1)] intValue];
            j--;
        }
        carry = sum / 2;
        sum = sum % 2;
        [res insertString:[NSString stringWithFormat:@"%d",sum] atIndex:0];
    }
    return res;
}
//真真为假 假假为假 假真为真 真假为真 比如 a=9（二进制1001），b=12（二进制1100），那么 a ^ b 的结果是5（二进制0101）
+ (void)XORTest {
//    1、有2n+1个数，只有一个单着，别的都是成对的，找出这个单着的数。比如：2 1 3 2 1。
//    异或计算，一趟搞定。时间复杂度o(n)，答案为３，因为两个相同的数异或为０．
    NSArray *array = @[@2,@1,@3,@2,@1];
    NSUInteger find = NSNotFound;
    for (NSNumber *num in array) {
        if(find == NSNotFound) {
            find = [num unsignedIntegerValue];
        }else{
            find = find ^ [num unsignedIntegerValue];
        }
    }
    NSLog(@"---> %s, array:%@ is not same = %lu",__FUNCTION__,array,(unsigned long)find);
    //    2、1-1000放在含有1001个元素的数组中，只有唯一的一个元素值重复，其它均只出现一次。每个数组元素只能访问一次，设计一个算法，将它找出来；不用辅助存储空间，能否设计一个算法实现？
    //
    //    答：
    //    令，1^2^…^1000（序列中不包含n）的结果为T
    //    则1^2^…^1000（序列中包含n）的结果就是T^n。
    //    T^(T^n)=n。
    //    所以，将所有的数全部异或，得到的结果与1^2^3^…^1000的结果进行异或，得到的结果就是重复数。
    int T = 1;
    for (int i = 2; i<=1000; i++) {
        T = T ^ i;
    }
    
    int intArray[1001];
    for (int i = 0; i<1000; i++) {
        intArray[i] = i+1;
    }
    intArray[1000] = 5;
    int findSame = T;
    for (int i=0 ; i< 1001; i++) {
        findSame = findSame ^ intArray[i];
    }
    NSLog(@"---> %s, findSame = %d",__FUNCTION__,findSame);
}
//Symbol       Value
//I             1
//V             5
//X             10
//L             50
//C             100
//D             500
//M             1000

//例如，两个用罗马数字写成II，只有两个加在一起。十二写为XII，简称为X + II。第二十七号写成XXVII，即XX + V + II。
//
//罗马数字通常从左到右从最大到最小。但是，四个数字不是IIII。相反，第四个写为IV。因为一个在五个之前，我们减去四个。同样的原则适用于九号，即九号。有六个使用减法的实例：
//
//我可以放在V（5）和X（10）之前制作4和9。
//X可以放在L（50）和C（100）之前，以产生40和90。
//C可以放在D（500）和M（1000）之前，以产生400和900。
+ (void)romanToInteger {
    NSDictionary *romanInt = @{
                               @"I":@1,
                               @"V":@5,
                               @"X":@10,
                               @"L":@50,
                               @"C":@100,
                               @"D":@500,
                               @"M":@1000
                               };
    NSString *roman = @"MCMXCIV";
    NSInteger count = [self romanToInteger:roman romanToIntDict:romanInt];
    NSLog(@"---> %s, %@ = %ld",__FUNCTION__,roman,count);
}

+ (NSInteger)romanToInteger:(NSString *)roman romanToIntDict:(NSDictionary *)dict {
    NSInteger result = 0;
    for(int i = ((int)roman.length - 1); i >= 0; i--) {
        NSString *current = [roman substringWithRange:NSMakeRange(i, 1)];
        if([dict.allKeys containsObject:current]) {
            if(i < ((int)roman.length - 1) && i >=0) {
                NSString *next = [roman substringWithRange:NSMakeRange(i+1, 1)];
                NSInteger currentInt = [[dict objectForKey:current] integerValue];
                NSInteger nextInt = [[dict objectForKey:next] integerValue];
                if(currentInt < nextInt) {
                    result -= currentInt;
                } else{
                    result += currentInt;
                }
            } else {
                result += [[dict objectForKey:current] integerValue];
            }
            
        } else {
            NSLog(@"---> %s, roman = %@ is not valib roman count",__FUNCTION__,roman);
            return result;
        }
    }
    return result;
}

//斐波那契数列  1 1 2 3 5 8 .... 定n个数是第n-1 和 n-2 的数之和。 f(n) = f(n-1) + f(n+2)
//求第100个数
+ (void)feibonaqi {
    NSUInteger num = [self feibonaqi:2000];
    NSLog(@"---> %s, num = %lu",__FUNCTION__,(unsigned long)num);
}

+ (NSUInteger)feibonaqi:(int)n {
    if(n == 0) {
        return 0;
    }
    if(n==1 || n ==2) {
        return 1;
    }
    int i = 3;
    NSUInteger current = 1;
    NSUInteger prev = 1;
    while (i <= n) {
        NSUInteger temp = current;
        current = current + prev;
        prev = temp;
        NSLog(@"---> %s,index = %d, current = %lu",__FUNCTION__,i,(unsigned long)current);
        if(NSUIntegerMax - current < current) {//下次必将溢出
            NSLog(@"---> %s, index = %d  is overflow",__FUNCTION__,i);
            break;
        }
        i++;
    }
    return current;
}

#pragma mark - Stack
//-------------Stack------------
//括号匹配
+ (void)validParentheses {
    NSString *testParenttheses = @"{}]";
    NSAssert(![self validParentheses:testParenttheses],@"%@ is not be valid",testParenttheses);
    
    
    NSString *testParenttheses2 = @"{[}]";
    NSAssert(![self validParentheses:testParenttheses2],@"%@ is not be valid",testParenttheses2);
    
    NSString *testParenttheses3 = @"[{[]}]";
    NSAssert([self validParentheses:testParenttheses3],@"%@ is must be valid",testParenttheses3);
    
    NSLog(@"validParentheses success");
}

+ (BOOL)validParentheses:(NSString *)parentheses {
    if(parentheses.length % 2 != 0) {
        return NO;
    }
    //左括号入栈
    //有括号匹配后出栈
    //栈空则为真
    NSMutableArray *stack = [NSMutableArray array];
    NSUInteger len = [parentheses length];
    for(int i = 0; i < len; i++) {
        NSString *current = [parentheses substringWithRange:NSMakeRange(i, 1)];
        if([current isEqualToString:@"{"] || [current isEqualToString:@"["]|| [current isEqualToString:@"("]) {
            [stack addObject:current];
        }else if([current isEqualToString:@"}"]) {
            if(stack.count > 0 && [[stack lastObject] isEqualToString:@"{"]) {
                [stack removeLastObject];
            } else {
                return NO;
            }
        }else if([current isEqualToString:@"]"]) {
            if(stack.count > 0 && [[stack lastObject] isEqualToString:@"["]) {
                [stack removeLastObject];
            } else {
                return NO;
            }
        }else if([current isEqualToString:@")"]) {
            if(stack.count > 0 && [[stack lastObject] isEqualToString:@"("]) {
                [stack removeLastObject];
            } else {
                return NO;
            }
        }
    }
    return stack.count == 0;
}

+ (void)absolutePath {
    NSString *path = @"/a/./b/../../c/";
    NSString *absolutePath = [self absolutePath:path];
    NSLog(@"---> %s Path = %@, absolutePath = %@",__FUNCTION__,path,absolutePath);
    
    
    NSString *path1 = @"/home/";
    NSString *absolutePath1 = [self absolutePath:path1];
    NSLog(@"---> %s path1 = %@, absolutePath1 = %@",__FUNCTION__,path1,absolutePath1);
}

+ (NSString *)absolutePath:(NSString *)path {
    NSArray *stackElements = [path componentsSeparatedByString:@"/"];
    Stack *stack = [[Stack alloc] init];
    for (NSString *dir in stackElements) {
        if([dir isEqualToString:@"."]) {
            continue;
        }
        if([dir isEqualToString:@".."]) {
            [stack pop];
        } else if(![dir isEqualToString:@""]) {
            [stack push:dir];
        }
    }
    NSString *result = stack.isEmpty ? @"/" : [NSString stringWithFormat:@"/%@",[stack.elements componentsJoinedByString:@"/"]];
    return result;
}

#pragma mark - Array
// --------------Array--------
+ (void)heaters {
    NSArray *heaters = @[@1,@5,@3];
    NSArray *houses = @[@1,@4,@3,@2];
    NSInteger raduis = [self radiusHeaters:heaters houses:houses];
    NSLog(@"houses = %@, heaters = %@, raduis = %ld",houses,heaters,raduis);
//    NSArray *heaters1 = @[@1,@27,@19];
//    NSArray *houses1 = @[@1,@3,@10,@8,@48,@14,@80,@100];
    NSArray *heaters1 = @[@2,@6];
    NSArray *houses1 = @[@1,@3];
    NSInteger raduis1 = [self radiusHeaters:heaters1 houses:houses1];
    NSLog(@"houses1 = %@, heaters1 = %@, raduis1 = %ld",houses1,heaters1,raduis1);
}

+ (NSInteger)radiusHeaters:(NSArray *)heaters  houses:(NSArray *)houses {
    NSInteger radius = 0;
    //从小到大排序
    heaters = [heaters sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return ([obj1 integerValue] < [obj2 integerValue]) ? NSOrderedAscending : NSOrderedDescending;
    }];
    houses = [houses sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return ([obj1 integerValue] < [obj2 integerValue]) ? NSOrderedAscending : NSOrderedDescending;
    }];
    int j = 0;
    for (int i = 0 ; i<houses.count; i++) {
        NSInteger currentHouse = [houses[i] integerValue];
        //右边加热器离当前房子更近则需要继续向右对比（因为加热器已经排好序，如果右边距离已经更远了，再继续对比获得的半径会更大，而事实上当前房子已经可以在加热器的最小半径中了），获取到所有房子距离加热器所需的最小半径，取最大的即可。
        while (j < heaters.count - 1 && labs([heaters[j+1] integerValue] - currentHouse) <= labs([heaters[j] integerValue] - currentHouse)) {
            j++;
        }
        radius = MAX(radius, labs(currentHouse - [heaters[j] integerValue]));
        NSLog(@"---> radius = %lu",radius);
    }
    
    return radius;
}
//0移动到数组最后
+ (void)moveZeroes {
    NSMutableArray *input = [@[@3,@0,@15,@0,@9,@8,@0] mutableCopy];
    NSMutableArray *output = [self moveZeroes1:input];
    NSLog(@"input : %@,output: %@",input,output);
}

+ (NSArray *)moveZeroes:(NSArray *)input {
    NSMutableArray *outPut = [NSMutableArray array];
    __block NSInteger zeroCount = 0;
    [input enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger num = [obj integerValue];
        if(num != 0){
            [outPut addObject:obj];
        }else{
            zeroCount++;
        }
    }];
    while (zeroCount > 0) {
        [outPut addObject:@(0)];
        zeroCount--;
    }
    return [outPut copy];
}

//space 为 O(1)
+ (NSMutableArray *)moveZeroes1:(NSMutableArray *)input {
    __block NSInteger index = 0;
    [input enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger num = [obj integerValue];
        if(num != 0){
            input[index] = obj;
            index++;
        }
    }];
    while (index < input.count) {
        input[index] = @0;
        index++;
    }
    return input;
}
// 给定一个整数数组，返回两个数字的索引，使它们加起来成为一个特定的目标。
// 您可以假定每个输入只有一个解决方案，并且不能使用同一个元素两次。
//遍历数组并存储目标, value为key，下标为值
+ (void)addSum {
    NSArray *numbers = @[@2,@10,@7,@18];
    NSInteger target = 9;
    NSArray *result = [self addSum:numbers target:target];
    NSLog(@"---->%s numbers = %@, target = %ld, indices = %@",__FUNCTION__,numbers,(long)target,result);
    
    NSInteger target1 = 17;
    NSArray *result1 = [self addSum:numbers target:target1];
    NSLog(@"---->%s numbers = %@, target1 = %ld, indices1 = %@",__FUNCTION__,numbers,(long)target1,result1);
    
}

+ (NSArray *)addSum:(NSArray *)numbers target:(NSInteger)target {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    NSMutableArray *resultArray = [NSMutableArray array];
    [numbers enumerateObjectsUsingBlock:^(NSNumber *num, NSUInteger idx, BOOL * _Nonnull stop) {
        if(resultDict[@(target - [num integerValue])]) {//字典存储的key中包含target - num，则表示找到了组合
            [resultArray addObject:resultDict[@(target - [num integerValue])]];
            [resultArray addObject:@(idx)];
            *stop = YES;
        } else {
            resultDict[num] = @(idx);
        }
    }];
    return [resultArray copy];
}
//有效数独
+ (void)validSudoku {
    NSArray *sudoku = @[
                        @[@"5",@"3",@".",@".",@"7",@".",@".",@".",@"."],
                        @[@"6",@".",@".",@"1",@"9",@"5",@".",@".",@"."],
                        @[@".",@"9",@"8",@".",@".",@".",@".",@"6",@"."],
                        @[@"8",@".",@".",@".",@"6",@".",@".",@".",@"3"],
                        @[@"4",@".",@".",@"8",@".",@"3",@".",@".",@"1"],
                        @[@"7",@".",@".",@".",@"2",@".",@".",@".",@"6"],
                        @[@".",@"6",@".",@".",@".",@".",@"2",@"8",@"."],
                        @[@".",@".",@".",@"4",@"1",@"9",@".",@".",@"5"],
                        @[@".",@".",@".",@".",@"8",@".",@".",@"7",@"9"],
                        ];
    BOOL valid = [self validSudoku:sudoku];
    NSAssert(valid, @"---->%s, suduku : %@ is valid",__FUNCTION__,sudoku);
    NSLog(@"---->%s, suduku : %@ is valid",__FUNCTION__,sudoku);
    NSArray *suduku2 = @[
                         @[@"8",@"3",@".",@".",@"7",@".",@".",@".",@"."],
                         @[@"6",@".",@".",@"1",@"9",@"5",@".",@".",@"."],
                         @[@".",@"9",@"8",@".",@".",@".",@".",@"6",@"."],
                         @[@"8",@".",@".",@".",@"6",@".",@".",@".",@"3"],
                         @[@"4",@".",@".",@"8",@".",@"3",@".",@".",@"1"],
                         @[@"7",@".",@".",@".",@"2",@".",@".",@".",@"6"],
                         @[@".",@"6",@".",@".",@".",@".",@"2",@"8",@"."],
                         @[@".",@".",@".",@"4",@"1",@"9",@".",@".",@"5"],
                         @[@".",@".",@".",@".",@"8",@".",@".",@"7",@"9"],
                         ];
    BOOL valid2 = [self validSudoku:suduku2];
    NSAssert(!valid2, @"---->%s, suduku2 : %@ is invalid",__FUNCTION__,suduku2);
    NSLog(@"---->%s, suduku2 : %@ is invalid",__FUNCTION__,suduku2);
}

+ (BOOL)validSudoku:(NSArray<NSArray *> *)sudoku {
    NSInteger y = sudoku.count;
    if(y!=9){
        return NO;
    }
    NSInteger x = sudoku[0].count;
    if(x!=9) {
        return NO;
    }
    NSMutableDictionary *visited = [NSMutableDictionary dictionary];
    //row
    for(int i = 0; i<y; i++){
        [visited removeAllObjects];
        for (int j = 0; j<x; j++) {
            BOOL valid = [self valid:sudoku[i][j] inVisited:visited];
            if(!valid) {
                return NO;
            }
        }
    }
    //clo
    for(int i = 0; i<x; i++){
        [visited removeAllObjects];
        for (int j = 0; j<y; j++) {
            BOOL valid = [self valid:sudoku[j][i] inVisited:visited];
            if(!valid) {
                return NO;
            }
        }
    }
    //Square
    for(int i = 0; i<3; i=i+3){
        for (int j = 0; j<3; j=j+3) {
            [visited removeAllObjects];
            for(int n = i; n<i+3; n++){
                for (int m = j; m<j+3; m++) {
                    BOOL valid = [self valid:sudoku[n][m] inVisited:visited];
                    if(!valid) {
                        return NO;
                    }
                }
            }
        }
    }
    return YES;
}

+ (BOOL)valid:(NSString *)numString inVisited:(NSMutableDictionary *)visited {
    if([numString isEqualToString:@"."]) {
        return YES;
    }
    NSInteger num = [numString integerValue];
    if(num < 1 || num > 9 || visited[numString]) {
        return NO;
    }
    visited[numString] = @"YES";
    return YES;
}

+ (void)sortMergeArray {
    int array[] = {6,5,3,9,1,8,7,2,4};
    //申请空间，使其大小为两个已经排序序列之和，该空间用来存放合并后的序列
    int len = sizeof(array)/sizeof(array[0]);
    int ressult[len];
    [self merge_sort_recursive:array result:ressult start:0 end:len - 1];
    NSLog(@"----> %s,sortArray = ",__FUNCTION__);
    for (int i = 0; i<len; i++) {
        NSLog(@"%d ",array[i]);
    }
}

+ (void)merge_sort_recursive:(int [])array result:(int [])result start:(int)start end:(int)end  {
    if(start >= end) {
        return;
    }
//    int mid = (end - start)/2 + start;
    int len = end - start, mid = (len >> 1) + start;
    //设定两个指针，最初位置分别为两个已经排序序列的起始位置
    int start1 = start;
    int end1 = mid;
    int start2 = mid + 1;
    int end2 = end;
    [self merge_sort_recursive:array result:result start:start1 end:end1];
    [self merge_sort_recursive:array result:result start:start2 end:end2];
    int k = start;
    //比较两个指针所指向的元素，选择相对小的元素放入到合并空间，并移动指针到下一位置
    while (start1 <= end1 && start2 <= end2) {
        result[k++] = array[start1] < array[start2] ? array[start1++] : array[start2++];
    }
    //还有剩下的 将另一序列剩下的所有元素直接复制到合并序列尾
    while (start1 <= end1) {
        result[k++] = array[start1++];
    }
    while (start2 <= end2) {
        result[k++] = array[start2++];
    }
    //copy
    for (k = start; k<= end; k++) {
        array[k] = result[k];
    }
}

+ (void)quickSortArray {
//    int array[] = {6,5,3,9,1,8,7,2,4};
//    int len = sizeof(array)/sizeof(array[0]);
//    [self quickSort:array];
//    NSLog(@"----> %s,quickSortArray = ",__FUNCTION__);
//    for (int i = 0; i<len; i++) {
//        NSLog(@"%d ",array[i]);
//    }
//    挑选基准值：从数列中挑出一个元素，称为“基准”（pivot），
//    分割：重新排序数列，所有比基准值小的元素摆放在基准前面，所有比基准值大的元素摆在基准后面（与基准值相等的数可以到任何一边）。在这个分割结束之后，对基准值的排序就已经完成，
//    递归排序子序列：递归地将小于基准值元素的子序列和大于基准值元素的子序列排序。
    NSArray *array = @[@6,@5,@3,@9,@1,@8,@7,@2,@4,@10,@3];
    array = [self quickSort:array];
    NSLog(@"----> %s,quickSortArray = %@",__FUNCTION__,array);
}

+ (NSArray *)quickSort:(NSArray *)array {
    if(array.count <= 1) {
        return array;
    }
    //选择基准值
    int pivot = [array[array.count/2] intValue];
    NSArray *left = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSNumber* val, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [val intValue] < pivot;
    }]];
    NSArray *middle = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSNumber* val, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [val intValue] == pivot;
    }]];
    NSArray *right = [array filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(NSNumber* val, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [val intValue] > pivot;
    }]];
    NSArray *result = [NSArray arrayWithArray:[self quickSort:left]];
    result = [result arrayByAddingObjectsFromArray:middle];
    result = [result arrayByAddingObjectsFromArray:[self quickSort:right]];
    return result;
}
//二分搜索
+ (void)binarySearchArray {
    NSArray *array = @[@1,@3,@4,@5,@7,@9,@10,@13,@17,@18,@19,@30];
    NSInteger find = 17;
    BOOL result = [self findNumber:find indexOfArray:array];
    
    NSAssert(result,@"----> %s find number = %ld in array = %@",__FUNCTION__,find,array);
    NSLog(@"----> %s find number = %ld in array = %@",__FUNCTION__,find,array);
}
+ (BOOL)findNumber:(NSInteger)number indexOfArray:(NSArray *)array {
    //递归
//    return [self findNumber:number indexOfArray:array left:0 right:array.count-1];
    //循环
    NSInteger left = 0;
    NSInteger right = array.count - 1;
    while (left < right) {
        NSInteger middle = (right - left)/2 + left;
        if([array[middle] integerValue] == number) {
            return YES;
        }else if([array[middle] integerValue] < number) {
            left = middle + 1;
        }else {
            right = middle - 1;
        }
    }
    return NO;
}
+ (BOOL)findNumber:(NSInteger)number indexOfArray:(NSArray *)array left:(NSInteger)left right:(NSInteger)right {
    if(left > right){
        return NO;
    }
    NSInteger middle = (right - left)/2 + left;
    if([array[middle] integerValue] == number) {
        return YES;
    }else if([array[middle] integerValue] < number) {
        return [self findNumber:number indexOfArray:array left:middle+1 right:right];
    }else {
        return [self findNumber:number indexOfArray:array left:left right:middle-1];
    }
}

#pragma mark - String
//----------String------------
//Example 1:
//Input: "A man, a plan, a canal: Panama"
//Output: true

//Example 2:
//Input: "race a car"
//Output: false
//需要去除符号，只比较数字和字母
//+ (BOOL)isValiadChar {
//    NSCharacterSet
//}

+ (void)validPalindrome{
    NSString *inputString = @"A man, a plan, a canal: Panama";
    NSAssert([self validPalindrome:inputString], @"%@ is validPalindrome",inputString);
    NSLog(@"%@ is validPalindrome",inputString);
    
    NSString *inputString1 = @"race a car";
    NSAssert(![self validPalindrome:inputString1], @"\"%@\" is not validPalindrome",inputString1);
    NSLog(@"\"%@\" is not validPalindrome",inputString1);
}

+ (BOOL)validPalindrome:(NSString *)string {
    if(!string){
        return NO;
    }
    string = [string lowercaseString];
    NSUInteger i = 0;
    NSUInteger j = string.length - 1;
    while (i<j) {
        //找到有效的左侧字母
        while(i<j && !(isalpha([string characterAtIndex:i]) || isnumber([string characterAtIndex:i]))){
            i++;
        }
        //找到有效的右侧字母
        while (i<j && !(isalpha([string characterAtIndex:j]) || isnumber([string characterAtIndex:j]))) {
            j--;
        }
        unichar left = [string characterAtIndex:i];
        unichar right = [string characterAtIndex:j];
        if(left != right){
            return NO;
        }else{
            i++;
            j--;
        }
        
    }
    return YES;
}
//删除一个字符，然后还能回放
+ (void)validPalindromeII {
    
    NSString *inputString = @"A man, a plan, a canal: Panama";
    NSAssert([self validPalindromeII:inputString], @"%@ is validPalindrome II",inputString);
    NSLog(@"%@ is validPalindrome",inputString);
    
    NSString *inputString1 = @"raca care ";
    NSAssert([self validPalindromeII:inputString1], @"\"%@\" is not validPalindrome II",inputString1);
    NSLog(@"\"%@\" is validPalindrome II",inputString1);
    
    
    NSString *inputString2 = @"3race a car";
    NSAssert(![self validPalindromeII:inputString2], @"\"%@\" is not validPalindrome II",inputString2);
    NSLog(@"\"%@\" is not validPalindrome II",inputString2);
}
+ (BOOL)validPalindromeII:(NSString *)string {
    if(!string){
        return NO;
    }
    string = [string lowercaseString];
    NSUInteger i = 0;
    NSUInteger j = string.length - 1;
    return [self validPalindromeII:string leftIndex:i rightIndex:j isMoved:NO];
}
//改下上面的回放算法即可，当对比为不一致时，需要删除一个字符，标记为已删除，但是左边和右边都要尝试删除
+ (BOOL)validPalindromeII:(NSString *)string leftIndex:(NSInteger)i rightIndex:(NSInteger)j isMoved:(BOOL)isMoved{
    while (i<j) {
        //找到有效的左侧字母
        while(i<j && !(isalpha([string characterAtIndex:i]) || isnumber([string characterAtIndex:i]))){
            i++;
        }
        //找到有效的右侧字母
        while (i<j && !(isalpha([string characterAtIndex:j]) || isnumber([string characterAtIndex:j]))) {
            j--;
        }
        unichar left = [string characterAtIndex:i];
        unichar right = [string characterAtIndex:j];
        if(left != right){
            if(isMoved){
                return NO;
            }
            return [self validPalindromeII:string leftIndex:i+1 rightIndex:j isMoved:YES] || [self validPalindromeII:string leftIndex:i rightIndex:j-1 isMoved:YES];
        }else{
            i++;
            j--;
        }
        
    }
    return YES;
}

+ (void)wordPattern {
    NSString *pattern = @"abba";
    NSString *word = @"dog fish fish dog";
    BOOL vaild = [self wordPattern:pattern word:word];
    NSAssert(vaild, @"--->%s pattern = %@ is mode of words = %@",__FUNCTION__,pattern,word);
    NSLog(@"--->%s pattern = %@ is mode of words = %@",__FUNCTION__,pattern,word);
    
    
    NSString *word1 = @"dog fish cat dog";
    BOOL vaild1 = [self wordPattern:pattern word:word1];
    NSAssert(!vaild1, @"--->%s pattern = %@ is not a mode of words = %@",__FUNCTION__,pattern,word1);
    NSLog(@"--->%s pattern = %@ is not a mode of word1 = %@",__FUNCTION__,pattern,word1);
}

+ (BOOL)wordPattern:(NSString *)pattern word:(NSString *)word {
    NSArray *words = [word componentsSeparatedByString:@" "];
    if(words.count != pattern.length) {
        return NO;
    }
    __block BOOL valid = YES;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [words enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *patternS = [NSString stringWithFormat:@"%C", [pattern characterAtIndex:idx]];
        if([dict.allKeys containsObject:patternS]) {
            if(![dict[patternS] isEqualToString:obj]) {
                valid = NO;
                *stop = YES;
            }
        } else {
            if([dict.allValues containsObject:obj]) {//key不存在但是word 属于别的key的 value，也是不符合规则
                valid = NO;
                *stop = YES;
            } else {
                dict[patternS] = obj;
            }
        }
    }];
    return valid;
}
    
+ (void)isomorphicStrings {
    NSString *t = @"egg";
    NSString *s = @"add";
    BOOL res = [self isomorphicStrings:t s:s];
    NSAssert(res, @"--->%s, %@ isomorphic %@",__FUNCTION__,s,t);
    
    NSString *t1 = @"pair";
    NSString *s1 = @"add";
    BOOL res1 = [self isomorphicStrings:t1 s:s1];
    NSAssert(!res1, @"--->%s, %@ not isomorphic %@",__FUNCTION__,s1,t1);
}

+ (BOOL)isomorphicStrings:(NSString *)t s:(NSString *)s {
    if(t.length != s.length) {
        return NO;
    }
    NSMutableDictionary *tDict = [NSMutableDictionary dictionary];
    NSMutableDictionary *sDict = [NSMutableDictionary dictionary];
    for (int i=0; i < t.length; i++) {
        NSString *currentT = [t substringWithRange:NSMakeRange(i, 1)];
        NSString *currentS = [s substringWithRange:NSMakeRange(i, 1)];
        if(!tDict[currentT] && !sDict[currentS]) {
            tDict[currentT] = currentS;
            sDict[currentS] = currentT;
        } else if(tDict[currentT] != currentS || sDict[currentS] != currentT){
            return NO;
        }
    }
    return YES;
}

#pragma mark - Tree
//-----------------Tree-------------------

/**
 列出数的所有叶子节点路径
 */
+ (void)binaryTreePaths {
    TreeNode *root = [[TreeNode alloc] initWithValue:1];
    [root addRandomSon];
    if(root.left){
        [root.left addRandomSon];
        if(root.left.left){
            [root.left.left addRandomSon];
        }
        if(root.left.right){
            [root.left.right addRandomSon];
        }
    }
    if(root.right){
        [root.right addRandomSon];
        if(root.right.left){
            [root.right.left addRandomSon];
        }
        if(root.right.right){
            [root.right.right addRandomSon];
        }
    }
    
    NSArray *result = [self binaryTreePaths:root];
    NSLog(@"---->%s nodeTree = %@ \n path = %@",__FUNCTION__,root.description,result);
}

+ (NSArray *)binaryTreePaths:(TreeNode *)root {
    NSMutableArray *resultArray = [NSMutableArray array];
    NSMutableString *path = [NSMutableString string];
    [self dfs:root path:path paths:resultArray];
    return [resultArray copy];
}

+ (void)dfs:(TreeNode *)node path:(NSMutableString *)path paths:(NSMutableArray *)paths{
    [self appendToPath:path node:node];
    if(node.left == nil && node.right == nil){//找到叶子
        [paths addObject:path];
        return;
    }
    
    if(node.left){
        NSMutableString *leftPath = [NSMutableString stringWithString:path];
        [self dfs:node.left path:leftPath paths:paths];
    }
    
    if(node.right){
        NSMutableString *rightPath = [NSMutableString stringWithString:path];
        [self dfs:node.right path:rightPath paths:paths];
    }
    
}

+ (void)appendToPath:(NSMutableString *)path node:(TreeNode *)node {
    if(path.length > 0){
        [path appendString:@"-"];
        [path appendString:@">"];
    }
    [path appendString:[node valString]];
}
+ (void)binaryTreeMaxDepth {
    NSArray *numbers1 = @[@5,@1,@4,[NSNull null],[NSNull null],@3,@6];
    TreeNode *root1 = [TreeNode createBinaryTreeNode:numbers1];
    NSInteger depth = [self maxDepth:root1];
    NSLog(@"---> %s tree = %@, depth is %ld",__FUNCTION__,numbers1,depth);

}
+ (NSInteger)maxDepth:(TreeNode *)binaryTree {
    if(!binaryTree){
        return 0;
    } else {
        return MAX([self maxDepth:binaryTree.left], [self maxDepth:binaryTree.right]) + 1;
    }
}

+ (void)levelOrderBinaryTree {
//    NSArray *numbers = @[@5,@3,@6,@1,@4,@3,@7];
    NSArray *numbers = @[@3,@9,@20,[NSNull null],[NSNull null],@15,@7];
    TreeNode *root = [TreeNode createBinaryTreeNode:numbers];
    NSArray *result = [self levelOrderBinaryTree:root];
    NSLog(@"---> %s , tree = %@, level order = %@",__FUNCTION__,numbers,result);
}
+ (NSArray *)levelOrderBinaryTree:(TreeNode *)tree {
    NSMutableArray *resultArray = [NSMutableArray array];
    
    Queue *queue = [[Queue alloc] init];
    if(tree) {
        [queue enqueue:tree];
    }
    while (queue.size) {
        NSInteger size = queue.size;
        NSMutableArray *level = [NSMutableArray array];
        for (int i = 0; i<size; i++) {
            TreeNode *node = [queue dequeue];
            [level addObject:@(node.val)];
            if(node.left){
                [queue enqueue:node.left];
            }
            if(node.right) {
                [queue enqueue:node.right];
            }
        }
        [resultArray addObject:level];
    }
    
    return [resultArray copy];
}

+ (void)DFSBinaryTree {
    NSArray *numbers = @[@5,@3,@6,@1,@4,@3,@7,@10,@13];
    TreeNode *root = [TreeNode createBinaryTreeNode:numbers];
    NSArray *result = [self DFSBinaryTree:root];
    NSLog(@"---> %s , tree = %@, level order = %@",__FUNCTION__,numbers,result);
}

+ (NSArray *)DFSBinaryTree:(TreeNode *)tree {
    NSMutableArray *result = [NSMutableArray array];
    Stack *nodeStack = [[Stack alloc] init];
    if(tree) {
        [nodeStack push:tree];
    }
    while(!nodeStack.isEmpty) {
        TreeNode *node = [nodeStack pop];
        [result addObject:@(node.val)];
        
        if(node.right) {
            [nodeStack push:node.right];
        }
        if (node.left) {
            [nodeStack push:node.left];
        }
    }
    return [result copy];
}



/**
 对称树
 */
+ (void)symmetricTree {
    NSArray *numbers = @[@1,@2,@2,@3,@4,@4,@3,@5,@6,@7,@8,@8,@7,@6,@5];
    TreeNode *root = [TreeNode createBinaryTreeNode:numbers];
    BOOL result = [self symmetricTree:root];
    NSAssert(result, @"---> %s, tree = %@ is symmetric Tree",__FUNCTION__,numbers);
    NSLog(@"---> %s, tree = %@ is symmetric Tree",__FUNCTION__,numbers);
    
    
    NSArray *numbers1 = @[@1,@2,@2,[NSNull null],@3,[NSNull null],@3];
    TreeNode *root1 = [TreeNode createBinaryTreeNode:numbers1];
    BOOL result1 = [self symmetricTree:root1];
    NSAssert(!result1, @"---> %s, tree = %@ is symmetric Tree",__FUNCTION__,numbers1);
    NSLog(@"---> %s, tree = %@  is not symmetric Tree",__FUNCTION__,numbers1);
    
}

+ (BOOL)symmetricTree:(TreeNode *)tree {
    if(!tree) {
        return NO;
    }
    return [self symmetricTreeHelper:tree.left right:tree.right];
}
+ (BOOL)symmetricTreeHelper:(TreeNode *)left right:(TreeNode *)right {
    if(!left && !right) {
        return YES;
    }
    if(!left || !right || right.val != left.val) {
        return NO;
    }
    return [self symmetricTreeHelper:left.left right:right.right] && [self symmetricTreeHelper:left.right right:right.left];
}
#pragma mark - Linked List
//---------------Linked List----------- 链表
+ (NodeList *)creatNodelist:(NSArray<NSNumber *> *)numbers {
    NSMutableArray *lists = [NSMutableArray array];
    for (int i = 0; i< numbers.count; i++) {
        NodeList *list = [[NodeList alloc] initWithValue:[numbers[i] integerValue]];
        [lists addObject:list];
    }
    for (int i = 0; i< lists.count - 1; i++) {
        NodeList *list = lists[i];
        list.next = lists[i+1];
    }
    return lists[0];
}
//翻转链表
+ (void)reverseLinkedList {
    NSArray *numbers = @[@1,@2,@3,@4,@5,@6,@7];
    NodeList *head = [self creatNodelist:numbers];
    NSLog(@"-----> %s,lists = %@",__FUNCTION__,head.description);
    NodeList *reverse = [self reverseLinkedList:head];
    NSLog(@"-----> %s,reverse lists= %@",__FUNCTION__, reverse);
}

+ (NodeList *)reverseLinkedList:(NodeList *)list {
    NodeList *first = list;
    NodeList *temp = nil;
    while (first) {
        NodeList *second = first.next;
        first.next = temp;
        temp = first;
        first = second;
    }
    return temp;
}

+ (void)mergeTwoSortedLists {
    NSArray *numbers = @[@1,@2,@4];
    NodeList *sorteHead1 = [self creatNodelist:numbers];
    NSArray *numbers1 = @[@1,@3,@4];
    NodeList *sorteHead2 = [self creatNodelist:numbers1];
    NodeList *post1 = sorteHead1;
    NodeList *post2 = sorteHead2;
    NodeList *dummy = [[NodeList alloc] initWithValue:0];
    NodeList *node = dummy;
    while (post1 || post1) {
        if(post1.val <= post2.val){
            node.next = post1;
            post1 = post1.next;
        } else {
            node.next = post2;
            post2 = post2.next;
        }
        node = node.next;
    }
    node.next = post1 ? post1 : post2;
    NSLog(@"-----> %s,numbers = %@ merge numbers1 = %@ lists= %@",__FUNCTION__,sorteHead1,sorteHead2,dummy.next);
}

+ (void)findLastIndexNode {
    NSArray *numbers = @[@1,@2,@3,@4,@5,@6,@7,@8,@9,@10];
    NodeList *list = [self creatNodelist:numbers];
    NSInteger lastIndex = 2;
    NodeList *targetList = list;
    NodeList *helperList = list;
    NSInteger current = 1;
    while (helperList) {
        helperList = helperList.next;
        if(current > lastIndex) {
            targetList = targetList.next;
        }
        current++;
    }
    
    NSLog(@"-----> %s,numbers = %@ lastIndex = %ld NodeVal = %ld",__FUNCTION__,numbers,lastIndex,(long)targetList.val);
}

// ------------------Dynamic programming----------------------
//
//你是一个专业的强盗，计划在街上抢劫房屋。每个房子都有一定数量的钱存在，阻止你抢劫他们的唯一限制是相邻的房屋有连接的安全系统，如果两个相邻的房子在同一个晚上被打破，它将自动联系警察。
//
//给出一个代表每个房子的金额的非负整数列表，确定今晚可以抢劫的最大金额而不警告警察。
//* Primary idea: Dynamic Programming, dp[i] = max(dp[i - 1], dp[i - 2] + nums[i]) o(n) o(1)
+ (void)houseRobber {
    int array[] = {6,5,3,9,1,8,7,2,4,10,13,2};
    //申请空间，使其大小为两个已经排序序列之和，该空间用来存放合并后的序列
    int len = sizeof(array)/sizeof(array[0]);
    int money1 = [self houseRobberOn:array len:len];
    int money2 = [self houseRobberO1:array len:len];
    NSAssert(money1 == money2, @"houseRobberOn should equal houseRobberO1");
    NSLog(@"---> %s,robber money = %d",__FUNCTION__,money1);
}
+ (int)houseRobberOn:(int [])array len:(int)len{
    //space(o(n))
    if(len == 1) {
        return array[0];
    }
    if(len == 2){
        return  MAX(array[0], array[1]);
    }
    int ressult[len];
    ressult[0] = array[0];
    ressult[1]= MAX(array[0], array[1]);
    int i = 2;
    for (i = 2;i<len;i++) {
        ressult[i] = MAX(ressult[i-2] + array[i], ressult[i-1]);
    }
    return ressult[i-1];
}

+ (int)houseRobberO1:(int [])array len:(int)len{
    //space(o(1))
    int preprev = 0;
    int prev = 0;
    int current = 0;
    for (int i = 0;i<len;i++) {
        current = MAX(array[i] + preprev, prev);
        preprev = prev;
        prev = current;
    }
    return current;
}

+ (void)houseRobberII {
//    int array[] = {6,5,3,9,1,8,7,2,4,10,13,2};
    int array[] = {8,2,3,7};

    //申请空间，使其大小为两个已经排序序列之和，该空间用来存放合并后的序列
    int len = sizeof(array)/sizeof(array[0]);
    int money1 = [self houseRobberII:array start:0 end:len-1];
    int money2 = [self houseRobberII:array start:1 end:len];
    int money = MAX(money1, money2);
    NSLog(@"---> %s,robber money = %d",__FUNCTION__,money);
}

+ (int)houseRobberII:(int [])array start:(int)start end:(int)end{
    //space(o(1))
    int preprev = 0;
    int prev = 0;
    int current = 0;
    for (int i = start;i<end;i++) {
        current = MAX(array[i] + preprev, prev);
        preprev = prev;
        prev = current;
    }
    return current;
}

//* Primary idea: Dynamic Programming, dp[i] = min(dp[i - 1], dp[i - 2] + nums[i]) o(n) o(1) ,  但是要保证最后走到了顶部
+ (void)minCostClimbingStair {
    NSArray *stair = @[@10, @15, @20];
//    NSArray *stair = @[@1, @100, @1, @1, @1, @100, @1, @1, @100, @1];
    NSInteger minCost = [self minCostClimbingStair:stair];
    NSLog(@"---> %s, minCost = %ld",__FUNCTION__,minCost);
}
+ (NSInteger)minCostClimbingStair:(NSArray *)array{
    NSInteger preprev = 0;
    NSInteger prev = NSIntegerMax;
    NSInteger current = NSIntegerMax;
    for (int i = 0; i<array.count; i++) {
        current = MIN([array[i] integerValue] + preprev, prev);
        preprev = prev;
        prev = current;
    }
    return current;
}
@end

