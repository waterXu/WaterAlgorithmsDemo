//
//  TreeNode.m
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2019/5/18.
//  Copyright © 2019年 xuyanlan. All rights reserved.
//

#import "TreeNode.h"

@implementation TreeNode
- (instancetype)initWithValue:(NSInteger)value {
    self = [super init];
    if(self){
        self.left = nil;
        self.right = nil;
        self.val = value;
    }
    return self;
}

- (void)addRandomSon {
    int i = 0;
    int count = arc4random() % 100;
    count = count % 2;
    while( i <= count) {
        NSInteger random = arc4random() % 3 + 1;
        TreeNode *left = [[TreeNode alloc] initWithValue:random];
        NSInteger random1 = arc4random() % 5 + 1;
        TreeNode *right = [[TreeNode alloc] initWithValue:random1];
        
        int carry = arc4random() % 3;
        if(carry==0){
            self.left = left;
        }else if(carry == 1){
            self.right = right;
        } else {
            self.left = left;
            self.right = right;
        }
        
//        self.left = left;
//        self.right = right;
        
        i++;
    }
    NSLog(@"%@", [self description]);
}
+ (TreeNode *)createBinaryTreeNode:(NSArray *)numbers {
    NSMutableArray *lists = [NSMutableArray array];
    for (id num in numbers) {
        if([num isKindOfClass:[NSNull class]]) {
            TreeNode *node = [[TreeNode alloc] init];
            node.valIsNull = YES;
            [lists addObject:node];
        } else {
            TreeNode *node = [[TreeNode alloc] initWithValue:[num integerValue]];
            [lists addObject:node];
        }
    }
    [self createBSTFromList:lists];
    TreeNode *root = lists[0];
    return root;
}

+ (TreeNode *)getTree:(NSArray *)numbers left:(NSInteger)left right:(NSInteger)right {
    if(left <= right) {
        NSInteger mid = (left + right)/2;
        if([numbers[mid] isKindOfClass:[NSNull class]]) {
            return nil;
        }
        TreeNode *node = [[TreeNode alloc] initWithValue:[numbers[mid] integerValue]];
        node.left = [self getTree:numbers left:left right:mid-1];
        node.right = [self getTree:numbers left:mid+1 right:right];
        return node;
    }else{
        return nil;
    }
}

+ (void)createBSTFromList:(NSArray<TreeNode *> *)list{
    NSInteger lastParentNode = list.count/2 - 1; //得到最后一个父节点的数组下标
    //      构建前lastParentNode-1个父节点的二叉树关系
    for (int parentIndex = 0; parentIndex <= lastParentNode; parentIndex++) {
        //构造左孩子
        list[parentIndex].left = list[parentIndex*2+1].valIsNull ? nil : list[parentIndex*2+1];
        //构造右孩子
        list[parentIndex].right = list[parentIndex*2+2].valIsNull ? nil : list[parentIndex*2+2];
    }
    // 构造最后一个父节点的孩纸
    // 左孩子
    list[lastParentNode].left = list[lastParentNode*2+1].valIsNull ? nil : list[lastParentNode*2+1];
    // 右孩子,如果数组长度为奇数则存在右孩子,否则不存在右孩子
    if(list.count%2==1){
        list[lastParentNode].right = list[lastParentNode*2+2].valIsNull ? nil : list[lastParentNode*2+2];
    }
}


- (NSString *)valString {
    return [NSString stringWithFormat:@"%lu",self.val];
}

- (NSString *)description {
    NSString *desc = [NSString stringWithFormat:@"nodeVal = %lu left = %lu, right = %ld",self.val,self.left ? self.left.val : 0,(long)(self.right ? self.right.val :0)];
    return desc;
}
@end

@implementation NodeList

- (instancetype)initWithValue:(NSInteger)value {
    self = [super init];
    if(self){
        self.next = nil;
        self.val = value;
    }
    return self;
}

- (NSString *)description {
    NSMutableString *path = [NSMutableString stringWithFormat:@"%lu",self.val];
    NodeList *list = self;
    while (list.next) {
        list = list.next;
        [path appendString:[NSString stringWithFormat:@"->%lu",list.val]];
    }
    return path;
}

@end
@interface Queue()
@property (nonatomic, strong) NSMutableArray *elements;
@property (nonatomic, strong) id peek;//队首元素
@property (nonatomic, assign) BOOL isEmpty;//是否为空
@property (nonatomic, assign) NSInteger size;//队列大小
@end
@implementation Queue
- (instancetype)init {
    self = [super init];
    if(self) {
        self.elements = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isEmpty {
    return self.elements.count == 0;
}

- (NSInteger)size {
    return self.elements.count;
}

- (void)enqueue:(id)element {
    [self.elements addObject:element];
}
- (id)dequeue {
    if(self.isEmpty) {
        return nil;
    }
    id element = [self.elements firstObject];
    [self.elements removeObjectAtIndex:0];
    return element;
}

@end

@interface Stack()
@property (nonatomic, strong) id peek;//栈顶元素
@property (nonatomic, assign) BOOL isEmpty;
@property (nonatomic, assign) NSInteger size;//栈大小
@property (nonatomic, strong) NSMutableArray *elements;
@end
@implementation Stack
- (instancetype)init {
    self = [super init];
    if(self) {
        self.elements = [NSMutableArray array];
    }
    return self;
}

- (BOOL)isEmpty {
    return self.elements.count == 0;
}

- (NSInteger)size {
    return self.elements.count;
}
- (void)push:(id)element {
    [self.elements addObject:element];
}
- (id)pop {
    if(self.isEmpty) {
        return nil;
    }
    id element = [self.elements lastObject];
    [self.elements removeLastObject];
    return element;
}


@end
