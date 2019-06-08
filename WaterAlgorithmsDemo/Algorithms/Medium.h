//
//  Medium.h
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2019/5/12.
//  Copyright © 2019年 xuyanlan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Medium : NSObject
//---------------Union Find--------------------

/**
 * 有多少小岛？
 * Question Link: https://leetcode.com/problems/number-of-islands-ii/
 * Primary idea: Classic Union Find, check four directions and update count every time
 *
 * Time Complexity: O(klogmn), Space Complexity: O(mn)
 *
 */
+ (void)numberOfIslands;

// -------------------Math---------------

// -------------------Array---------------

/**
 3个数相加为0
 * Question Link: https://leetcode.com/problems/3sum/
 * Primary idea: Sort the array, and traverse it, increment left or decrease right
 *               predicated on their sum is greater or not than the target
 * Time Complexity: O(n^2), Space Complexity: O(nC3)
 */
+ (void)threeSum;

//-----------------tree--------------
+ (void)validateBinarySearchTree;

//
//小偷又发现了自己盗窃的新地方。这个区域只有一个入口，称为“根”。除了根，每个房子只有一个父母的房子。巡回演出后，聪明的小偷意识到“这个地方的所有房屋都形成了一棵二叉树”。如果两个直接连接的房屋在同一个晚上被闯入，它将自动联系警方。
//
//确定小偷今晚可以抢劫的最大金额而不警告警察。
+ (void)houseRobberIII;

@end

NS_ASSUME_NONNULL_END
