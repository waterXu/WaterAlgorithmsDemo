//
//  MediumViewController.m
//  WaterAlgorithmsDemo
//
//  Created by xuyanlan on 2019/5/12.
//  Copyright © 2019年 xuyanlan. All rights reserved.
//
#import "Medium.h"
#import "MediumViewController.h"
@interface MediumViewController()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSDictionary *> *dataSoource;
@end
@implementation MediumViewController
- (NSArray<NSDictionary *> *)dataSoource {
    if (_dataSoource == nil) {
        _dataSoource = @[
                         //---------------Union Find--------------------
                         @{@"name":@"Number of Islands",@"function":@"numberOfIslands"},
                         // -------------------Array---------------
                         @{@"name":@"3Sum",@"function":@"threeSum"},
                         //-----------------tree--------------
                         @{@"name":@"Validate Binary Search Tree",@"function":@"validateBinarySearchTree"},
                         @{@"name":@"houseRobberIII",@"function":@"houseRobberIII"},
                         ];
    }
    return _dataSoource;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat: @"Medium 进度:%lu / 20",self.dataSoource.count];
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
    [Medium performSelector:function];
}

@end
