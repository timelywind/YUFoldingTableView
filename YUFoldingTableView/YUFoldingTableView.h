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
 *  箭头的位置
 */
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView;
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
 *  header的标题
 */
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger )section;
/**
 *  返回cell
 */
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  点击cell
 */
- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  箭头图片
 */
- (UIImage *)yuFoldingTableView:(YUFoldingTableView *)yuTableView arrowImageForSection:(NSInteger )section;

// 下面是一些属性的设置

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

@end
