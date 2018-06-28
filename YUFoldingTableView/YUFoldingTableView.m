//
//  YUFoldingTableView.m
//  YUFoldingTableView
//
//  Created by administrator on 16/8/24.
//  Copyright © 2016年 timelywind. All rights reserved.
//

#import "YUFoldingTableView.h"

static NSString *YUFoldingSectionHeaderID = @"YUFoldingSectionHeader";
static NSInteger addTag = 100;

id YUSafeObject(NSArray *array, NSInteger index) {
    
    if (![array isKindOfClass:[NSArray class]]) {
        return nil;
    }
    if (array.count <= index) {
        return nil;
    }
    
    return [array objectAtIndex:index];
}

@interface YUFoldingTableView () <YUFoldingSectionHeaderDelegate>

@property (nonatomic, strong, readwrite) NSMutableArray *statusArray;

@end

@implementation YUFoldingTableView

#pragma mark - 初始化

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDelegateAndDataSource];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

#pragma mark - 创建数据源和代理

- (void)setupDelegateAndDataSource
{
    // 适配iOS 11
#ifdef __IPHONE_11_0
//    if ([self respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
//        self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//    }
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
#endif
    self.delegate = self;
    self.dataSource = self;
    if (self.style == UITableViewStylePlain) {
        self.tableFooterView = [[UIView alloc] init];
    }
    
    [self registerClass:[YUFoldingSectionHeader class] forHeaderFooterViewReuseIdentifier:YUFoldingSectionHeaderID];
    
    // 添加监听
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onChangeStatusBarOrientationNotification:)  name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
}

- (NSMutableArray *)statusArray
{
    if (!_statusArray) {
        _statusArray = [NSMutableArray array];
    }
    
    if (!_foldingState) {
        _foldingState = YUFoldingSectionStateFlod;
    }
    
    if (_statusArray.count) {
        if (_statusArray.count > self.numberOfSections) {
            [_statusArray removeObjectsInRange:NSMakeRange(self.numberOfSections - 1, _statusArray.count - self.numberOfSections)];
        }else if (_statusArray.count < self.numberOfSections) {
            for (NSInteger i = self.numberOfSections - _statusArray.count; i < self.numberOfSections; i++) {
                [_statusArray addObject:[NSNumber numberWithInteger:_foldingState]];
            }
        }
    }else{
        for (NSInteger i = 0; i < self.numberOfSections; i++) {
            [_statusArray addObject:[NSNumber numberWithInteger:_foldingState]];
        }
    }
    
    if (_sectionStateArray.count) {
        NSMutableArray *tempStatusArrayM = [NSMutableArray array];
        for (int i = 0; i < _statusArray.count; i++) {
            if (i < _sectionStateArray.count) {
                [tempStatusArrayM addObject:_sectionStateArray[i]];
            } else {
                [tempStatusArrayM addObject:@"0"];
            }
        }
        _statusArray = tempStatusArrayM;
        _sectionStateArray = nil;
    }
    
    
    return _statusArray;
}

- (void)onChangeStatusBarOrientationNotification:(NSNotification *)notification
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self reloadData];
    });
}

#pragma mark - UI Configration

- (YUFoldingSectionHeaderArrowPosition )perferedArrowPosition
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(perferedArrowPositionForYUFoldingTableView:)]) {
        return [_foldingDelegate perferedArrowPositionForYUFoldingTableView:self];
    }
    return YUFoldingSectionHeaderArrowPositionRight;
}
- (UIColor *)backgroundColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:backgroundColorForHeaderInSection:)]) {
        return [_foldingDelegate yuFoldingTableView:self backgroundColorForHeaderInSection:section];
    }
    return [UIColor colorWithRed:102/255.f green:102/255.f blue:255/255.f alpha:1.f];
}
- (NSString *)titleForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:titleForHeaderInSection:)]) {
        return [_foldingDelegate yuFoldingTableView:self titleForHeaderInSection:section];
    }
    return [NSString string];
}
- (UIFont *)titleFontForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:fontForTitleInSection:)]) {
        return [_foldingDelegate yuFoldingTableView:self fontForTitleInSection:section];
    }
    return [UIFont boldSystemFontOfSize:16];
}
- (UIColor *)titleColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:textColorForTitleInSection:)]) {
        return [_foldingDelegate yuFoldingTableView:self textColorForTitleInSection:section];
    }
    return [UIColor whiteColor];
}
- (NSString *)descriptionForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:descriptionForHeaderInSection:)]) {
        return [_foldingDelegate yuFoldingTableView:self descriptionForHeaderInSection:section];
    }
    return [NSString string];
}
- (UIFont *)descriptionFontForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:fontForDescriptionInSection:)]) {
        return [_foldingDelegate yuFoldingTableView:self fontForDescriptionInSection:section];
    }
    return [UIFont boldSystemFontOfSize:13];
}

- (UIColor *)descriptionColorForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:textColorForDescriptionInSection:)]) {
        return [_foldingDelegate yuFoldingTableView:self textColorForDescriptionInSection:section];
    }
    return [UIColor whiteColor];
}

- (UIImage *)arrowImageForSection:(NSInteger )section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:arrowImageForSection:)]) {
        return [_foldingDelegate yuFoldingTableView:self arrowImageForSection:section];
    }
    return [UIImage imageNamed:@"YUFolding_arrow"];
}

#pragma mark - UITableViewDelegate / UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(numberOfSectionForYUFoldingTableView:)]) {
        return [_foldingDelegate numberOfSectionForYUFoldingTableView:self];
    }else{
        return self.numberOfSections;
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([YUSafeObject(self.statusArray, section) integerValue] == YUFoldingSectionStateShow) {
        if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:numberOfRowsInSection:)]) {
            return [_foldingDelegate yuFoldingTableView:self numberOfRowsInSection:section];
        }
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:heightForHeaderInSection:)]) {
        return [_foldingDelegate yuFoldingTableView:self heightForHeaderInSection:section];
    }else{
        return self.sectionHeaderHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:heightForRowAtIndexPath:)]) {
        return [_foldingDelegate yuFoldingTableView:self heightForRowAtIndexPath:indexPath];
    }else{
        return self.rowHeight;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (self.style == UITableViewStylePlain) {
        return 0;
    }else{
        return 0.001;
    }
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *sectionHeaderView = nil;
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:viewForHeaderInSection:)]) {
        sectionHeaderView = [_foldingDelegate yuFoldingTableView:self viewForHeaderInSection:section];
        sectionHeaderView.tag = addTag + section;
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGestureAction:)];
        [sectionHeaderView addGestureRecognizer:tapGesture];
    } else {
        sectionHeaderView = [self normalHeaderViewWithTableView:tableView section:section];
    }
    return sectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:cellForRowAtIndexPath:)]) {
        return [_foldingDelegate yuFoldingTableView:self cellForRowAtIndexPath:indexPath];
    }
    return [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DefaultCellIndentifier"];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:didSelectRowAtIndexPath:)]) {
        [_foldingDelegate yuFoldingTableView:self didSelectRowAtIndexPath:indexPath];
    }
}


#pragma mark - YUFoldingSectionHeader

- (UIView *)normalHeaderViewWithTableView:(UITableView *)tableView section:(NSInteger)section
{
    YUFoldingSectionHeader *sectionHeaderView = [self dequeueReusableHeaderFooterViewWithIdentifier:YUFoldingSectionHeaderID];
    [sectionHeaderView configWithBackgroundColor:[self backgroundColorForSection:section]
                                     titleString:[self titleForSection:section]
                                      titleColor:[self titleColorForSection:section]
                                       titleFont:[self titleFontForSection:section]
                               descriptionString:[self descriptionForSection:section]
                                descriptionColor:[self descriptionColorForSection:section]
                                 descriptionFont:[self descriptionFontForSection:section]
                                      arrowImage:[self arrowImageForSection:section]
                                   arrowPosition:[self perferedArrowPosition]
                                    sectionState:[YUSafeObject(self.statusArray, section) integerValue]
                                    sectionIndex:section];
    sectionHeaderView.tapDelegate = self;
    return sectionHeaderView;
}

- (void)tapGestureAction:(UIGestureRecognizer *)gesture
{
    [self yuFoldingSectionHeaderTappedAtIndex:gesture.view.tag - addTag];
}

- (void)yuFoldingSectionHeaderTappedAtIndex:(NSInteger)index
{
    if (self.statusArray.count <= index) {
        return;
    }
    BOOL currentIsOpen = [YUSafeObject(self.statusArray, index) boolValue];
    
    [self.statusArray replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:!currentIsOpen]];
    
    NSInteger numberOfRow = [_foldingDelegate yuFoldingTableView:self numberOfRowsInSection:index];
    NSMutableArray *rowArray = [NSMutableArray array];
    if (numberOfRow) {
        for (NSInteger i = 0; i < numberOfRow; i++) {
            [rowArray addObject:[NSIndexPath indexPathForRow:i inSection:index]];
        }
    }
    if (rowArray.count) {
        if (currentIsOpen) {
            [self deleteRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
        }else{
            [self insertRowsAtIndexPaths:[NSArray arrayWithArray:rowArray] withRowAnimation:UITableViewRowAnimationTop];
        }
    }
    
    if (_foldingDelegate && [_foldingDelegate respondsToSelector:@selector(yuFoldingTableView:didSelectHeaderViewAtSection:)]) {
        [_foldingDelegate yuFoldingTableView:self didSelectHeaderViewAtSection:index];
    }
}



@end
