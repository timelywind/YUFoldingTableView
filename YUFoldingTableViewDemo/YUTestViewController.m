//
//  YUTestViewController.m
//  YUFoldingTableViewDemo
//
//  Created by administrator on 16/8/25.
//  Copyright © 2016年 timelywind. All rights reserved.
//

#import "YUTestViewController.h"

@interface YUTestViewController ()

@property (nonatomic, weak) YUFoldingTableView *foldingTableView;


@end

@implementation YUTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    // 创建tableView
    [self setupFoldingTableView];
}

// 创建tableView
- (void)setupFoldingTableView
{
    self.automaticallyAdjustsScrollViewInsets = NO;
    CGFloat topHeight = [[UIApplication sharedApplication] statusBarFrame].size.height + 44;
    YUFoldingTableView *foldingTableView = [[YUFoldingTableView alloc] initWithFrame:CGRectMake(0, topHeight, self.view.bounds.size.width, self.view.bounds.size.height - topHeight)];
    _foldingTableView = foldingTableView;
    
    [self.view addSubview:foldingTableView];
    foldingTableView.foldingDelegate = self;
    
    if (self.arrowPosition) {
        foldingTableView.foldingState = YUFoldingSectionStateShow;
    }
    if (self.index == 2) {
        foldingTableView.sectionStateArray = @[@"1", @"0", @"0"];
    }
}

#pragma mark - YUFoldingTableViewDelegate / required（必须实现的代理）
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    return 6;
}
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section
{
    return 3;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section
{
    return 50;
}
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [yuTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"Row %ld -- section %ld", (long)indexPath.row, (long)indexPath.section];

    return cell;
}
#pragma mark - YUFoldingTableViewDelegate / optional （可选择实现的）

- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger)section
{
    return [NSString stringWithFormat:@"Title %ld",(long)section];
}

- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [yuTableView deselectRowAtIndexPath:indexPath animated:YES];
}

// 返回箭头的位置
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView
{
    // 没有赋值，默认箭头在左
    return self.arrowPosition ? :YUFoldingSectionHeaderArrowPositionLeft;
}

- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section
{
    return @"detailText";
}

//- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView backgroundColorForHeaderInSection:(NSInteger)section
//{
//    
//    return self.arrowPosition ? [UIColor whiteColor] : [UIColor colorWithRed:102/255.f green:102/255.f blue:255/255.f alpha:1.f];
//}
//
//- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView textColorForTitleInSection:(NSInteger)section
//{
//    return self.arrowPosition ? [UIColor redColor] : [UIColor whiteColor];
//}

@end
