//
//  EasyViewController.m
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2019/5/8.
//  Copyright © 2019年 xuyanlan. All rights reserved.
//

#import "EasyViewController.h"
#import "Easy.h"

@interface EasyViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSArray *> *dataSource;
@property (nonatomic, strong) NSArray<NSString *> *sectionSource;
@end

@implementation EasyViewController
- (NSArray<NSString *> *)sectionSource {
    if(!_sectionSource) {
        _sectionSource = @[@"Math",@"Stack",@"Array",@"String",@"Tree",@"Linked List",@"DP-动态规划"];
    }
    return _sectionSource;
}
- (NSArray<NSArray *> *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[
                         @[//Math
                         @{@"name":@"Plus One",@"function":@"plusOne"},
                         @{@"name":@"PowerOfTwo",@"function":@"powerOfTwo"},
                         @{@"name":@"powerOfThree",@"function":@"powerOfThree"},
                         @{@"name":@"powerOfFour",@"function":@"powerOfFour"},
                         @{@"name":@"addBinary",@"function":@"addBinary"},
                         @{@"name":@"XORTest",@"function":@"XORTest"},
                         @{@"name":@"斐波那契数列",@"function":@"feibonaqi"},
                         ],
                         //Stack
                         @[
                         @{@"name":@"Valid Parentheses",@"function":@"validParentheses"},
                         @{@"name":@"absolutePath",@"function":@"absolutePath"},
                         ],
                         @[
                         //Array
                         @{@"name":@"Heaters",@"function":@"heaters"},
                         @{@"name":@"moveZeroes",@"function":@"moveZeroes"},
                         @{@"name":@"addSum",@"function":@"addSum"},
                         @{@"name":@"validSudoku",@"function":@"validSudoku"},
                         @{@"name":@"sortMergeArray",@"function":@"sortMergeArray"},
                         @{@"name":@"quickSortArray",@"function":@"quickSortArray"},
                         @{@"name":@"binarySearchArray 二分搜索",@"function":@"binarySearchArray"},
                         ],
                         //String
                         @[
                         @{@"name":@"validPalindrome",@"function":@"validPalindrome"},
                         @{@"name":@"validPalindromeII",@"function":@"validPalindromeII"},
                         @{@"name":@"Word Pattern",@"function":@"wordPattern"},
                         @{@"name":@"Isomorphic Strings 字符同构",@"function":@"isomorphicStrings"},
                         @{@"name":@"Valid Anagram 同字母异序",@"function":@"validAnagram"},
                         ],
                         //Tree
                         @[
                         @{@"name":@"binaryTreePaths",@"function":@"binaryTreePaths"},
                         @{@"name":@"binaryTreeMaxDepth",@"function":@"binaryTreeMaxDepth"},
                         @{@"name":@"levelOrderBinaryTree BFS",@"function":@"levelOrderBinaryTree"},
                         @{@"name":@"DFSBinaryTree ",@"function":@"DFSBinaryTree"},
                         @{@"name":@"Symmetric Tree 对称树",@"function":@"symmetricTree"},
                         ],
                         //---------------Linked List-----------
                         @[
                         @{@"name":@"Reverse Linked List",@"function":@"reverseLinkedList"},
                         @{@"name":@"Merge Two Sorted Lists",@"function":@"mergeTwoSortedLists"},
                         @{@"name":@"findLastIndexNode",@"function":@"findLastIndexNode"},
                         ],
                         @[
                         //Dynamic programming 动态规划
                         @{@"name":@"House Robber",@"function":@"houseRobber"},
                         @{@"name":@"House Robber II",@"function":@"houseRobberII"},
                         @{@"name":@"min Cost Climbing Stair",@"function":@"minCostClimbingStair"},
                         ]
                         ];
        
    }
    return _dataSource;
}
__weak id reference = nil;
    
- (void)viewDidLoad {
    [super viewDidLoad];
    NSInteger count = 0;
    for (NSArray *section in self.dataSource) {
        count = count + section.count;
    }
    self.navigationItem.title = [NSString stringWithFormat: @"Easy 进度:%lu / 50",count];
    self.navigationController.navigationBarHidden = NO;
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
//    [self.tableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"cellHeader"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.sectionHeaderHeight = 44;
    [self.view addSubview:self.tableView];
    NSString *str = [NSString stringWithFormat:@"aaa"];
    // str 是一个 autorelease 对象，设置一个 weak 的引用来观察它。
    reference = str;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@", reference); // Console: (null)
}
    
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.tableView reloadData];
    NSLog(@"%@", reference); // Console: aaa
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSource[indexPath.section][indexPath.row][@"name"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionSource[section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
    
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionSource.count;
}
    
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource[section].count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *func = self.dataSource[indexPath.section][indexPath.row][@"function"];
    SEL function = NSSelectorFromString(func);
    if([func isEqualToString:@"plusOne"]) {
//        Easy *easy = [[Easy alloc] init];
        [Easy performSelector:function];
        return;
    }
    [Easy performSelector:function];
    
}

@end
