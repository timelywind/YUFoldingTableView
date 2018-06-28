//
//  YUCustomTestController.m
//  YUFoldingTableViewDemo
//
//  Created by caiyi on 2018/2/6.
//  Copyright © 2018年 timelywind. All rights reserved.
//

#import "YUCustomTestController.h"
#import "YUCustomHeaderView.h"

@interface YUCustomTestController ()

@end

@implementation YUCustomTestController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (UIView *)yuFoldingTableView:(YUFoldingTableView *)yuTableView viewForHeaderInSection:(NSInteger)section
{
    static NSString *headerIdentifier = @"headerIdentifier";
    YUCustomHeaderView *headerFooterView = [yuTableView dequeueReusableHeaderFooterViewWithIdentifier:headerIdentifier];
    if (headerFooterView == nil) {
        headerFooterView = [[YUCustomHeaderView alloc] initWithReuseIdentifier:headerIdentifier];
    }
    
    NSLog(@"当前状态%@", yuTableView.statusArray[section]);
    
    
    headerFooterView.contentView.backgroundColor = [UIColor colorWithRed:200/255.0 green:200/255.0 blue:200/255.0 alpha:0.2];
    headerFooterView.title = [NSString stringWithFormat:@"标题 - %ld", section];
    headerFooterView.descriptionText = [NSString stringWithFormat:@"自定义的sectionHeaderView - %ld", section];
    return headerFooterView;
}

- (void)yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectHeaderViewAtSection:(NSInteger)section
{
    NSLog(@"点击了headerView - %ld", section);
}

@end
