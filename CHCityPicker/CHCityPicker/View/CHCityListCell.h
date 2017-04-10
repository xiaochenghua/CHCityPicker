//
//  CHCityListCell.h
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/19.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCityListCell : UITableViewCell
/**
 *  行高
 */
@property (nonatomic, assign) CGFloat rowHeight;

/**
 *  配置Cell
 *
 *  @param array 给定数组
 */
- (void)configCityListCellWithCityNames:(NSArray<NSString *> *)array;

/**
 *  给定位Cell设置标题
 *
 *  @param title 标题
 */
- (void)setLocationCellSubviewWithTitle:(NSString *)title;

@end
