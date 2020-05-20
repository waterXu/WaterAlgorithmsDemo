//
//  Medium.m
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2019/5/12.
//  Copyright © 2019年 xuyanlan. All rights reserved.
//

#import "Medium.h"
#import "TreeNode.h"
static NSInteger times = 0;
@implementation Medium
//- (void)testSignature  {
//    NSLog(@"---> %s",__FUNCTION__);
//}


+ (void)numberOfIslands {
    NSArray<NSArray *> *lands = @[
                                  @[@1,@1,@1,@0],
                                  @[@1,@1,@1,@0],
                                  @[@1,@0,@1,@0],
                                  @[@0,@0,@0,@0],
                                  @[@1,@0,@0,@0],
                                  ];
    NSInteger res = [self numberOfIslands:lands];
    NSLog(@"---->%s lands : %@  has %ld lands",__FUNCTION__, lands,res);
    NSArray<NSArray *> *lands1 = @[
                                  @[@1,@1,@0,@0,@0],
                                  @[@1,@1,@0,@0,@0],
                                  @[@0,@0,@1,@0,@0],
                                  @[@0,@0,@0,@1,@1],
                                  ];
    NSInteger res1 = [self numberOfIslands:lands1];
    NSLog(@"---->%slands1 : %@  has %ld lands",__FUNCTION__,lands1,res1);
}

+ (NSInteger)numberOfIslands:(NSArray<NSArray*> *)lands {
    NSInteger res = 0;
    NSInteger lineX = lands.count;
    NSInteger lineY = lands[0].count;
    NSMutableDictionary *visitDict = [NSMutableDictionary dictionary];
    for (int i = 0; i< lineX; i++) {
        for (int j = 0; j < lineY; j++) {
            NSString *key = [NSString stringWithFormat:@"%d-%d",i,j];
            if([lands[i][j] integerValue] == 0 || [visitDict.allKeys containsObject:key]){
                continue;
            }
            [self visitToDict:visitDict x:i y:j lands:lands];
            res++;
        }
    }
    return res;
}

+ (void)visitToDict:(NSMutableDictionary *)visitDict x:(int)x y:(int)y lands:(NSArray <NSArray*> *)lands {
    NSString *key = [NSString stringWithFormat:@"%d-%d",x,y];
    NSInteger lineX = lands.count;
    NSInteger lineY = lands[0].count;
    if(x < 0 || x >= lineX || y < 0 || y >= lineY || [lands[x][y] integerValue] == 0 || [visitDict.allKeys containsObject:key]){
        return;
    }
    [visitDict setObject:@"true" forKey:key];
    [self visitToDict:visitDict x:x-1 y:y lands:lands];
    [self visitToDict:visitDict x:x+1 y:y lands:lands];
    [self visitToDict:visitDict x:x y:y-1 lands:lands];
    [self visitToDict:visitDict x:x y:y+1 lands:lands];
}

//--------------Array------------------
//数组中3个数相加为0的组合
+ (void)threeSum {
    times = 0;
    NSArray *numbers = @[@-1, @0, @-7,@1, @2,@-9, @-1, @-4,@5,@8,@2,@11,@16,@6];
//    NSArray *numbers = @[@-1, @0, @1, @2, @-1, @-4];
    NSArray *result = [self threeSum:numbers];
    NSLog(@"----> %s,times = %ld, numbers = %@, zero sum = %@ count = %lu",__FUNCTION__,times,numbers,result,(unsigned long)result.count);
    
    times = 0;
    NSArray *result1 = [self threeSum2:numbers];
    NSLog(@"----> %s,times = %ld, numbers = %@, zero sum = %@ count = %lu",__FUNCTION__,times,numbers,result1,(unsigned long)result1.count);
}

+ (NSArray *)threeSum:(NSArray *)numbers {
//    NSArray *sortNumbers = [numbers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
//        return ([obj1 integerValue] < [obj2 integerValue]) ? NSOrderedAscending : NSOrderedDescending;
//    }];
    NSMutableArray *lessZeroNumbers = [NSMutableArray array];
    NSMutableArray *moreThanZeroNumbers = [NSMutableArray array];
    NSMutableArray *resultArray = [NSMutableArray array];
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    for (NSNumber *num in numbers) {
        if([num integerValue] < 0) {
            [lessZeroNumbers addObject:num];
        } else {
            [moreThanZeroNumbers addObject:num];
        }
        times ++;
    }
    for (int i = 0;i<lessZeroNumbers.count;i++) {
        NSNumber *num = lessZeroNumbers[i];
//        if(i > 0 && num == lessZeroNumbers[i-1]){//和上一个相同，则跳过
//            continue;
//        }
        NSMutableArray *result = [self addSum:moreThanZeroNumbers target:([num integerValue] * -1)];
        //或者使用不排序的方法，用key记录是否出现过同一个结果，结果相同则不添加,空间换时间
        if(result.count > 0){
            [result addObject:num];
            NSString *key = [NSString stringWithFormat:@"%@-%@-%@",result[0],result[1],result[2]];
            if(![resultDict.allKeys containsObject:key]){
                [resultArray addObject:result];
                [resultDict setObject:@"1" forKey:key];
            }
        }
        times ++;
    }
    for (int i = 0;i<moreThanZeroNumbers.count;i++) {//和上一个相同，则跳过
        NSNumber *num = moreThanZeroNumbers[i];
//        if(i > 0 && num == moreThanZeroNumbers[i-1]){
//            continue;
//        }
        NSMutableArray *result = [self addSum:lessZeroNumbers target:([num integerValue] * -1)];
        if(result.count > 0){
            [result addObject:num];
            NSString *key = [NSString stringWithFormat:@"%@-%@-%@",result[0],result[1],result[2]];
            if(![resultDict.allKeys containsObject:key]){
                [resultArray addObject:result];
                [resultDict setObject:@"1" forKey:key];
            }
        }
        times ++;
    }
    return [resultArray copy];
}
+ (NSMutableArray *)addSum:(NSArray *)numbers target:(NSInteger)target {
    NSMutableDictionary *resultDict = [NSMutableDictionary dictionary];
    NSMutableArray *resultArray = [NSMutableArray array];
    [numbers enumerateObjectsUsingBlock:^(NSNumber *num, NSUInteger idx, BOOL * _Nonnull stop) {
        if(resultDict[@(target - [num integerValue])]) {//字典存储的key中包含target - num，则表示找到了组合
            [resultArray addObject:@(target - [num integerValue])];
            [resultArray addObject:num];
            //不可行,不能退出
            *stop = YES;
        } else {
            resultDict[num] = @(idx);
        }
        times ++;
    }];
    return resultArray;
}


+ (NSArray *)threeSum2:(NSArray *)numbers {
    numbers = [numbers sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        times ++;
        return ([obj1 integerValue] < [obj2 integerValue]) ? NSOrderedAscending : NSOrderedDescending;
    }];
    NSMutableArray *resultArray = [NSMutableArray array];
    for (int i = 0;i<numbers.count - 2; i++) {
        times++;
        if(i == 0 || numbers[i] != numbers[i-1] ){
            NSInteger remain = -[numbers[i] integerValue];
            int left = i + 1;
            int right = numbers.count - 1;
            while (left < right) {
                if(([numbers[left] integerValue] + [numbers[right] integerValue]) == remain){
                    NSMutableArray *result = [NSMutableArray array];
                    [result addObject: numbers[i]];
                    [result addObject:numbers[left]];
                    [result addObject:numbers[right]];
                    [resultArray addObject:result];
                    do {
                        times++;
                        left += 1;
                    } while (left < right && ([numbers[left] integerValue] == [numbers[left - 1] integerValue]));
                    
                    do {
                        right -= 1;
                        times++;
                    } while (left < right && ([numbers[right] integerValue] == [numbers[right + 1] integerValue]));
                    
                } else if([numbers[left] integerValue] + [numbers[right] integerValue] < remain){
                    do {
                        left += 1;
                        times++;
                    } while (left < right && ([numbers[left] integerValue] == [numbers[left - 1] integerValue]));
                    
                } else {
                    do {
                        right -= 1;
                        times++;
                    } while (left < right && ([numbers[right] integerValue] == [numbers[right + 1] integerValue]));
                }
            }
        }
    }
    
    
    return [resultArray copy];
}
#pragma -mark tree
//-------------------Tree------------------
//是否为平衡二叉树
+ (void)validateBinarySearchTree {
    NSArray *numbers = @[@2,@1,@3];
    TreeNode *root = [TreeNode createBinaryTreeNode:numbers];
    BOOL valid = [self validateBinarySearchTree:root];
    NSAssert(valid, @"---> %s numbers = %@ is validateBinarySearchTree",__FUNCTION__,numbers);
    NSLog(@"---> %s numbers = %@ is validateBinarySearchTree",__FUNCTION__,numbers);
    
    
    NSArray *numbers1 = @[@5,@1,@4,[NSNull null],[NSNull null],@3,@6];
    TreeNode *root1 = [TreeNode createBinaryTreeNode:numbers1];
    BOOL valid1 = [self validateBinarySearchTree:root1];
    NSAssert(!valid1, @"---> %s numbers1 = %@ is invalidate Binary Search Tree",__FUNCTION__,numbers1);
    NSLog(@"---> %s numbers1 = %@ is invalidate Binary Search Tree",__FUNCTION__,numbers1);
    
    times = 0;
    NSArray *numbers2 = @[@5,@3,@6,@1,@4,@3,@7];
    TreeNode *root2 = [TreeNode createBinaryTreeNode:numbers2];
    BOOL valid2 = [self validateBinarySearchTree:root2];
    NSAssert(valid2, @"---> %s numbers2 = %@ is validate Binary Search Tree",__FUNCTION__,numbers2);
    NSLog(@"---> %s numbers2 = %@ is validate Binary Search Tree,times = %ld",__FUNCTION__,numbers2,times);
    
    
}

+ (BOOL)validateBinarySearchTree:(TreeNode *)tree {
//    return [self helper:tree min:nil max:nil];
    return [self helper:tree minNode:tree.left maxNode:tree.right];
}

+ (BOOL)helper:(TreeNode *)node minNode:(TreeNode *)minNode maxNode:(TreeNode *)maxNode {
    if(!node){
        times ++;
        return YES;
    }
    if(minNode && node.val <= minNode.val){
        times ++;
        return NO;
    }
    if(maxNode && node.val >= maxNode.val) {
        times ++;
        return NO;
    }
    times ++;
    return [self helper:node.left minNode:minNode.left maxNode:minNode.right] && [self helper:node.right minNode:maxNode.left maxNode:maxNode.right];
}

+ (BOOL)helper:(TreeNode *)node min:(NSNumber *)min max:(NSNumber *)max {
    if(!node){
        times ++;
        return YES;
    }
    // 所有右子节点都必须大于根节点
    if(min && node.val <= [min integerValue]){
        times ++;
        return NO;
    }
    // 所有左子节点都必须小于根节点
    if(max && node.val >= [max integerValue]) {
        times ++;
        return NO;
    }
    times ++;
    BOOL left = [self helper:node.left min:nil max:@(node.val)];
    BOOL right = [self helper:node.right min:@(node.val) max:nil];
    return left && right;
}

+ (void)houseRobberIII {
//Input: [3,2,3,null,3,null,1]
//
//    3
//    / \
//    2   3
//    \   \
//    3   1
// 7
//Input: [3,4,5,1,3,null,1]
//
//    3
//    / \
//    4   5
//    / \   \
//    1   3   1
//
//Output: 9
    
    //Input: [3,2,3,5,3,4,1]
    //
    //        3
    //       / \
    //      2   3
    //     /\   /\
    //    5  3 4 1
    //   /\
    //  8  1
    // 20
//    NSArray *house = @[@3,@2,@3,[NSNull null],@3,[NSNull null],@1];
//    NSArray *house = @[@3,@4,@5,@1,@3,[NSNull null],@1];
    NSArray *house = @[@3,@2,@3,@5,@3,@4,@1,@8,@1];
    TreeNode *root = [TreeNode createBinaryTreeNode:house];
    NSInteger money1 = [self houseRobberIIIRobber:root];
    NSInteger money2 = [self houseRobberIIINotRobber:root];
    NSInteger money = MAX(money1, money2);
    NSLog(@"--->%s this tree house = %@,robber money = %ld",__FUNCTION__,house,money);
}

//* Primary idea: Using two sums to track rob sum starting from current node or not,
//*                 compare and get the maximum one
+ (NSInteger)houseRobberIIIRobber:(TreeNode *)tree{
    if(!tree) {
        return 0;
    }
    return [self houseRobberIIINotRobber:tree.left] + [self houseRobberIIINotRobber:tree.right] + tree.val;
}

+ (NSInteger)houseRobberIIINotRobber:(TreeNode *)tree{
    if(!tree) {
        return 0;
    }
    NSInteger money = [self houseRobberIIIRobber:tree.left] + [self houseRobberIIIRobber:tree.right];
    NSInteger money1 = [self houseRobberIIINotRobber:tree.left] + [self houseRobberIIIRobber:tree.right];
    NSInteger money2 = [self houseRobberIIIRobber:tree.left] + [self houseRobberIIINotRobber:tree.right];
    NSInteger money3 = [self houseRobberIIINotRobber:tree.left] + [self houseRobberIIINotRobber:tree.right];
    return MAX(MAX(money, money1), MAX(money2, money3));
}
#pragma -mark dp
// ------------------dp------------------
//股票买卖最大利润 ，买入要早于卖出 ,可以多次交易
//关键：当天卖出以后，当天还可以买入,所以算法可以直接简化为只要今天比昨天大，就卖出。
+ (void)bestTimeToBuyandSellStockII {
//    NSArray *stock = @[@6, @7, @3, @4, @8, @5, @9];
    NSArray *stock = @[@7, @1, @5, @3, @2, @6, @4];
    NSInteger max = [self bestTimeToBuyandSellStockII:stock];
    NSLog(@"----> %s, stock = %@ -- max = %ld",__FUNCTION__,stock,max);
}

+ (NSInteger)bestTimeToBuyandSellStockII:(NSArray *)stock {
    if (!stock || stock.count < 2) {
        return 0;
    }
    NSInteger result = 0;
    for (int i = 1; i<stock.count; i++) {
        if([stock[i] integerValue] > [stock[i-1] integerValue]){
            result = result + ([stock[i] integerValue] - [stock[i-1] integerValue]);
        }
    }
    return result;
}
@end
