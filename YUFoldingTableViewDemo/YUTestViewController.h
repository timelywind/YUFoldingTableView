//
//  YUTestViewController.h
//  YUFoldingTableViewDemo
//
//  Created by administrator on 16/8/25.
//  Copyright © 2016年 timelywind. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YUFoldingTableView.h"

@interface YUTestViewController : UIViewController  <YUFoldingTableViewDelegate>

@property (nonatomic, assign) YUFoldingSectionHeaderArrowPosition arrowPosition;

@property (nonatomic, assign) NSInteger index;

@end
