//
//  Easy.h
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2019/5/8.
//  Copyright © 2019年 xuyanlan. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Easy : NSObject
//-------------Math------------
//加一算法
/**
 * Question Link: https://leetcode.com/problems/plus-one/
 * Primary idea: Iterate and change the array from last to the first
 *
 * Time Complexity: O(n), Space Complexity: O(1)
 */
+ (void)plusOne;
//判断数是否为2，3，4的次方
/**
 * Question Link: https://leetcode.com/problems/power-of-two/
 * Primary idea: Use and to solve the problem
 * Time Complexity: O(1), Space Complexity: O(1)
 *
 */
+ (void)powerOfTwo;
+ (void)powerOfThree;
+ (void)powerOfFour;
/**
 * Question Link: https://leetcode.com/problems/add-binary/
 * Primary idea: use Carry and iterate from last to start
 *
 * Note: Swift does not have a way to access a character in a string with O(1),
 *       thus we have to first transfer the string to a character array
 * Time Complexity: O(n), Space Complexity: O(n)
 *
 */
+ (void)addBinary;

//异或运算
//真真为假 假假为假 假真为真 真假为真 比如 a=9（二进制1001），b=12（二进制1100），那么 a ^ b 的结果是5（二进制0101）
+ (void)XORTest;

//罗马数字转数字
+ (void)romanToInteger;
//斐波那契数列
+ (void)feibonaqi;

//-------------Stack------------
//括号匹配
/**
 * Question Link: https://leetcode.com/problems/valid-parentheses/
 * Primary idea: Use a stack to see whether the peek left brace is correspond to the current right one
 * Time Complexity: O(n), Space Complexity: O(n)
 */
+ (void)validParentheses;

/**
 Given an absolute path for a file (Unix-style), simplify it.
 For example,
 path = "/home/", => "/home"
 path = "/a/./b/../../c/", => "/c"
 */
+ (void)absolutePath;

// --------------Array--------
//加热半径
/**
 * Question Link: https://leetcode.com/problems/heaters/
 * Primary idea: Two pointers, get the closest heater for the house, and update radius
 * Time Complexity: O(nlogn), Space Complexity: O(1)
 *
 */
+ (void)heaters;

//0移动到数组最后
/**
 * Question Link: https://leetcode.com/problems/move-zeroes/
 * Primary idea: keep index for element not equal to 0, traverse and set up the index
 *
 * Time Complexity: O(n), Space Complexity: O(1)
 *
 */
+ (void)moveZeroes;


/**
 * Question Link: https://leetcode.com/problems/two-sum/
 * Primary idea: Traverse the array and store target - nums[i] in a dict
 *
 * Time Complexity: O(n), Space Complexity: O(n)
 */
+ (void)addSum;
//有效数独
/**
 * Question Link: https://leetcode.com/problems/valid-sudoku/
 * Primary idea: Check rows, columns, and single square separately
 *
 * Time Complexity: O(n^2), Space Complexity: O(n)
 */
+ (void)validSudoku;
//归并排序
+ (void)sortMergeArray;
//快速排序
+ (void)quickSortArray;
//二分搜索
+ (void)binarySearchArray;
// -----------String------------
//正反读都一样
/**
 * Given a string, determine if it is a palindrome, considering only alphanumeric characters and ignoring cases.
 * Question Link: https://leetcode.com/problems/valid-palindrome/
 * Primary idea: For every index in the first half of the String, compare two values at mirroring indices.
 *
 * Time Complexity: O(n), Space Complexity: O(n)
 *
 */
+ (void)validPalindrome;
//去除一个字符后 正反读都一样
/**
 *Given a non-empty string s, you may delete at most one character. Judge whether you can make it a palindrome.
 * Question Link: https://leetcode.com/problems/valid-palindrome-ii/
 * Primary idea: Take advantage of validPalindrome, and jump left and right separately to get correct character should be deleted
 *
 * Time Complexity: O(n), Space Complexity: O(n)
 *
 */

+ (void)validPalindromeII;
//单词是否符合 pattern 的模式
/**
 * Question Link: https://leetcode.com/problems/word-pattern/
 * Primary idea: Use two dictionarys to determine if a character is unique to a word
 * Time Complexity: O(n), Space Complexity: O(n)
 */
+ (void)wordPattern;
    
    /**
     * Question Link: https://leetcode.com/problems/isomorphic-strings/
     * Primary idea: Use two dictionaries to help
     * Time Complexity: O(n), Space Complexity: O(n)
     */
//判断两个字符是否同构
+ (void)isomorphicStrings;
//同字母异序 判断
/**
* Question Link: https://leetcode.com/problems/valid-anagram/
* Primary idea: Transfer string to char array and sort, compare the sort one
* Time Complexity: O(nlogn), Space Complexity: O(1)
*/
+ (void)validAnagram;
//-----------------tree-------------------

/**
 列出数的所有叶子节点路径
* Question Link: https://leetcode.com/problems/binary-tree-paths/
* Primary idea: Classic DFS problem, add the path to paths when the node is leaf
* Time Complexity: O(n), Space Complexity: O(n)
*
* Definition for a binary tree node.
* public class TreeNode {
    *     public var val: Int
    *     public var left: TreeNode?
    *     public var right: TreeNode?
    *     public init(_ val: Int) {
        *         self.val = val
        *         self.left = nil
        *         self.right = nil
        *     }
    * }
*/
+ (void)binaryTreePaths;

/**
 二叉树的深度
 */
+ (void)binaryTreeMaxDepth;

/**
 层级遍历，广度优先遍历 BFS  queue
 */
+ (void)levelOrderBinaryTree;


/**
 深度优先遍历 DFS   stack
 */
+ (void)DFSBinaryTree;

/**
 对称树
 */
+ (void)symmetricTree;


//---------------Linked List----------- 链表
/**
 * Question Link: https://leetcode.com/problems/reverse-linked-list/
 * Primary idea: Use two helper nodes, traverse the linkedlist and change point direction each time
 * Time Complexity: O(n), Space Complexity: O(1)
 *
 * Definition for singly-linked list.
 * public class ListNode {
 *     public var val: Int
 *     public var next: ListNode?
 *     public init(_ val: Int) {
 *         self.val = val
 *         self.next = nil
 *     }
 * }
 */
//翻转链表
+ (void)reverseLinkedList;

/**
 merge two sorted list
 
 */
+ (void)mergeTwoSortedLists;
//查找倒数第 n 个节点
+ (void)findLastIndexNode;

// ------------------Dynamic programming----------------------
//
//你是一个专业的强盗，计划在街上抢劫房屋。每个房子都有一定数量的钱存在，阻止你抢劫他们的唯一限制是相邻的房屋有连接的安全系统，如果两个相邻的房子在同一个晚上被打破，它将自动联系警察。
//
//给出一个代表每个房子的金额的非负整数列表，确定今晚可以抢劫的最大金额而不警告警察。
+ (void)houseRobber;
//和houseRobber不同的是房子是环形的，也就是说首尾不能一起偷
    
+ (void)houseRobberII;
//最低成本走到楼梯顶部，可以依次走一步或两步
+ (void)minCostClimbingStair;
//股票买卖最大利润 ，买入要早于卖出, 一次交易 只买卖一次
// https://leetcode.com/problems/best-time-to-buy-and-sell-stock/
+ (void)bestTimeToBuyandSellStock;
@end

NS_ASSUME_NONNULL_END
