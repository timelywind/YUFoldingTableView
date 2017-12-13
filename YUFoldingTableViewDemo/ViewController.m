//
//  ViewController.m
//  YUFoldingTableViewDemo
//
//  Created by administrator on 16/8/24.
//  Copyright © 2016年 timelywind. All rights reserved.
//

#import "ViewController.h"
#import "YUFoldingTableView.h"
#import "YUTestViewController.h"


@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, assign) YUFoldingSectionHeaderArrowPosition arrowPosition;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"demo演示";
    // 创建tableView
    [self setupTableView];
}

// 创建tableView
- (void)setupTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat topHeight = [[UIApplication sharedApplication] statusBarFrame].size.height + 44;
    UITableView *tableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, topHeight, self.view.bounds.size.width, self.view.bounds.size.height - topHeight)];
    _tableView = tableView;
    tableView.rowHeight = 50;
    [self.view addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.textLabel.text = [NSString stringWithFormat:@"test %ld (%@)",indexPath.row + 1, indexPath.row ? @"默认展开" : @"默认关闭"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YUTestViewController *testVc = [[YUTestViewController alloc] init];
    testVc.arrowPosition = indexPath.row;
    [self.navigationController pushViewController:testVc animated:YES];
}

@end
