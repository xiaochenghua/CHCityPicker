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
 *  初始化
 *
 *  @param style           style
 *  @param reuseIdentifier reuseIdentifier
 *  @param array           给定数组
 *
 *  @return 已初始化的Cell
 */
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cityNames:(NSArray<NSString *> *)array;

/**
 *  配置Cell子控件标题
 */
- (void)configTitleForCellSubView;

@end
