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
@property (nonatomic, strong) NSArray<NSDictionary *> *dataSoource;
@end

@implementation EasyViewController

- (NSArray<NSDictionary *> *)dataSoource {
    if (_dataSoource == nil) {
        _dataSoource = @[
                         //Math
                         @{@"name":@"Plus One",@"function":@"plusOne"},
                         @{@"name":@"PowerOfTwo",@"function":@"powerOfTwo"},
                         @{@"name":@"powerOfThree",@"function":@"powerOfThree"},
                         @{@"name":@"powerOfFour",@"function":@"powerOfFour"},
                         @{@"name":@"addBinary",@"function":@"addBinary"},
                         @{@"name":@"XORTest",@"function":@"XORTest"},
                         @{@"name":@"Roman To Int",@"function":@"romanToInteger"},
                         //Stack
                         @{@"name":@"Valid Parentheses",@"function":@"validParentheses"},
                         @{@"name":@"absolutePath",@"function":@"absolutePath"},
                         //Array
                         @{@"name":@"Heaters",@"function":@"heaters"},
                         @{@"name":@"moveZeroes",@"function":@"moveZeroes"},
                         @{@"name":@"addSum",@"function":@"addSum"},
                         @{@"name":@"validSudoku",@"function":@"validSudoku"},
                         @{@"name":@"sortMergeArray",@"function":@"sortMergeArray"},
                         @{@"name":@"quickSortArray",@"function":@"quickSortArray"},
                         @{@"name":@"binarySearchArray 二分搜索",@"function":@"binarySearchArray"},
                         //String
                         @{@"name":@"validPalindrome",@"function":@"validPalindrome"},
                         @{@"name":@"validPalindromeII",@"function":@"validPalindromeII"},
                         @{@"name":@"Word Pattern",@"function":@"wordPattern"},
                         //Tree
                         @{@"name":@"binaryTreePaths",@"function":@"binaryTreePaths"},
                         @{@"name":@"binaryTreeMaxDepth",@"function":@"binaryTreeMaxDepth"},
                         @{@"name":@"levelOrderBinaryTree",@"function":@"levelOrderBinaryTree"},
                         //---------------Linked List-----------
                         @{@"name":@"Reverse Linked List",@"function":@"reverseLinkedList"},
                         @{@"name":@"Merge Two Sorted Lists",@"function":@"mergeTwoSortedLists"},
                         @{@"name":@"findLastIndexNode",@"function":@"findLastIndexNode"},
                         //Dynamic programming 动态规划
                         @{@"name":@"House Robber",@"function":@"houseRobber"},
                         ];
    }
    return _dataSoource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat: @"Easy 进度:%lu / 50",self.dataSoource.count];
    self.navigationController.navigationBarHidden = NO;
    self.tableView = [[UITableView alloc] init];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    self.tableView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.tableView reloadData];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = self.dataSoource[indexPath.row][@"name"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSoource.count;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *func = self.dataSoource[indexPath.row][@"function"];
    SEL function = NSSelectorFromString(func);
//    if([func isEqualToString:@"plusOne"]) {
//        Easy *easy = [[Easy alloc] init];
//        [easy performSelector:function];
//        return;
//    }
    [Easy performSelector:function];
    
}

@end
