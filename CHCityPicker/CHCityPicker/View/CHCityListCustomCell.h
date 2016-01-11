//
//  CHCityListCustomCell.h
//  CHCityPicker
//
//  Created by APP on 16/1/11.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityListBaseCell.h"

@class CHCityButton;

@interface CHCityListCustomCell : CHCityListBaseCell

/**
 *  初始化Cell数据
 *
 *  @param array 给定数组
 *
 *  @return Cell
 */
- (instancetype)initWithCityNames:(NSArray<NSString *> *)array;

/**
 *  配置Cell按钮的标题
 */
- (void)configCellTitle;
@end
