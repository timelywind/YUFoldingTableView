//
//  YUFoldingTableView.h
//  YUFoldingTableView
//
//  Created by administrator on 16/8/24.
//  Copyright © 2016年 timelywind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUFoldingSectionHeader.h"

@class YUFoldingTableView;

@protocol YUFoldingTableViewDelegate <NSObject>

@required
/**
 *  返回section的个数
 */
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView;
/**
 *  cell的个数
 */
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section;
/**
 *  header的高度
 */
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section;
/**
 *  cell的高度
 */
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  返回cell
 */
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  点击cell
 */
- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  点击sectionHeaderView
 */
- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectHeaderViewAtSection:(NSInteger)section;

/**
 *  返回HeaderView
 */
- (UIView *)yuFoldingTableView:(UITableView *)yuTableView viewForHeaderInSection:(NSInteger)section;

/************* 下面是关于headerView一些属性的设置 ************/

/**
 *  header的标题
 */
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger )section;

/**
 *  箭头的位置
 */
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView;

/**
 *  箭头图片
 */
- (UIImage *)yuFoldingTableView:(YUFoldingTableView *)yuTableView arrowImageForSection:(NSInteger )section;

- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section;

- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView backgroundColorForHeaderInSection:(NSInteger )section;

- (UIFont *)yuFoldingTableView:(YUFoldingTableView *)yuTableView fontForTitleInSection:(NSInteger )section;

- (UIFont *)yuFoldingTableView:(YUFoldingTableView *)yuTableView fontForDescriptionInSection:(NSInteger )section;

- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView textColorForTitleInSection:(NSInteger )section;

- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView textColorForDescriptionInSection:(NSInteger )section;

@end

@interface YUFoldingTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<YUFoldingTableViewDelegate> foldingDelegate;

@property (nonatomic, assign) YUFoldingSectionState foldingState;

@property (nonatomic, strong, readonly) NSMutableArray *statusArray;

// 控制默认section的展开状态
@property (nonatomic, copy) NSArray *sectionStateArray;

@end
