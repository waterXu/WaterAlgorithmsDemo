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

@end

NS_ASSUME_NONNULL_END
