//
//  YUFoldingTableView.h
//  YUFoldingTableView
//
//  Created by administrator on 16/8/24.
//  Copyright © 2016年 liufengting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUFoldingSectionHeader.h"


#pragma mark - YUFoldingTableViewDelegate

@class YUFoldingTableView;

@protocol YUFoldingTableViewDelegate <NSObject>

@required
/**
 *  perferedArrowPositionForYUFoldingTableView
 *
 *  @param yuTableView YUFoldingTableView
 *
 *  @return YUFoldingSectionHeaderArrowPosition
 */
- (YUFoldingSectionHeaderArrowPosition)perferedArrowPositionForYUFoldingTableView:(YUFoldingTableView *)yuTableView;
/**
 *  numberOfSectionForYUFoldingTableView
 *
 *  @param yuTableView YUFoldingTableView
 *
 *  @return NSInteger
 */
- (NSInteger )numberOfSectionForYUFoldingTableView:(YUFoldingTableView *)yuTableView;
/**
 *  numberOfRowsInSection
 *
 *  @param yuTableView YUFoldingTableView
 *  @param section     NSInteger
 *
 *  @return NSInteger
 */
- (NSInteger )yuFoldingTableView:(YUFoldingTableView *)yuTableView numberOfRowsInSection:(NSInteger )section;
/**
 *  heightForHeaderInSection
 *
 *  @param yuTableView YUFoldingTableView
 *  @param section     NSInteger
 *
 *  @return CGFloat
 */
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForHeaderInSection:(NSInteger )section;
/**
 *  heightForRowAtIndexPath
 *
 *  @param yuTableView YUFoldingTableView
 *  @param indexPath   NSIndexPath
 *
 *  @return CGFloat
 */
- (CGFloat )yuFoldingTableView:(YUFoldingTableView *)yuTableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  titleForHeaderInSection
 *
 *  @param yuTableView YUFoldingTableView
 *  @param section     NSInteger
 *
 *  @return NSString
 */
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView titleForHeaderInSection:(NSInteger )section;
/**
 *  cellForRowAtIndexPath
 *
 *  @param yuTableView YUFoldingTableView
 *  @param indexPath   NSIndexPath
 *
 *  @return UITableViewCell
 */
- (UITableViewCell *)yuFoldingTableView:(YUFoldingTableView *)yuTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  didSelectRowAtIndexPath
 *
 *  @param yuTableView YUFoldingTableView
 *  @param indexPath   NSIndexPath
 */
- (void )yuFoldingTableView:(YUFoldingTableView *)yuTableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

/**
 *  arrowImageForSection
 *
 *  @param yuTableView YUFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIImage
 */
- (UIImage *)yuFoldingTableView:(YUFoldingTableView *)yuTableView arrowImageForSection:(NSInteger )section;
/**
 *  descriptionForHeaderInSection
 *
 *  @param yuTableView YUFoldingTableView
 *  @param section     NSInteger
 *
 *  @return NSString
 */
- (NSString *)yuFoldingTableView:(YUFoldingTableView *)yuTableView descriptionForHeaderInSection:(NSInteger )section;
/**
 *  backgroundColorForHeaderInSection
 *
 *  @param yuTableView YUFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIColor
 */
- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView backgroundColorForHeaderInSection:(NSInteger )section;
/**
 *  fontForTitleInSection
 *
 *  @param yuTableView YUFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIFont
 */
- (UIFont *)yuFoldingTableView:(YUFoldingTableView *)yuTableView fontForTitleInSection:(NSInteger )section;
/**
 *  fontForDescriptionInSection
 *
 *  @param yuTableView YUFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIFont
 */
- (UIFont *)yuFoldingTableView:(YUFoldingTableView *)yuTableView fontForDescriptionInSection:(NSInteger )section;
/**
 *  textColorForTitleInSection
 *
 *  @param yuTableView YUFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIColor
 */
- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView textColorForTitleInSection:(NSInteger )section;
/**
 *  textColorForDescriptionInSection
 *
 *  @param yuTableView YUFoldingTableView
 *  @param section     NSInteger
 *
 *  @return UIColor
 */
- (UIColor *)yuFoldingTableView:(YUFoldingTableView *)yuTableView textColorForDescriptionInSection:(NSInteger )section;

@end

@interface YUFoldingTableView : UITableView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) id<YUFoldingTableViewDelegate> foldingDelegate;

@end
