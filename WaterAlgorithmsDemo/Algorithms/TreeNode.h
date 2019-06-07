//
//  TreeNode.h
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2019/5/18.
//  Copyright © 2019年 xuyanlan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject
@property(nonatomic, strong) TreeNode *left;
@property(nonatomic, strong) TreeNode *right;
@property(nonatomic, assign) NSInteger val;
@property(nonatomic, assign) BOOL valIsNull;
@property(nonatomic, assign) BOOL visited;


- (instancetype)initWithValue:(NSInteger)value;
- (void)addRandomSon;
- (NSString *)valString;
+ (TreeNode *)createBinaryTreeNode:(NSArray *)numbers;
@end


@interface NodeList : NSObject
@property(nonatomic, strong) NodeList *next;
@property(nonatomic, assign) NSInteger val;
- (instancetype)initWithValue:(NSInteger)value;
@end

@interface Queue : NSObject
@property (nonatomic, strong, readonly) id peek;//队首元素
@property (nonatomic, assign, readonly) BOOL isEmpty;//是否为空
@property (nonatomic, assign, readonly) NSInteger size;//队列大小
@property (nonatomic, strong, readonly) NSMutableArray *elements;
- (void)enqueue:(id)element;
- (id)dequeue;
@end

@interface Stack : NSObject
@property (nonatomic, strong, readonly) id peek;//栈顶元素
@property (nonatomic, assign, readonly) BOOL isEmpty;
@property (nonatomic, assign, readonly) NSInteger size;//栈大小
@property (nonatomic, strong, readonly) NSMutableArray *elements;
- (void)push:(id)element;
- (id)pop;

@end
