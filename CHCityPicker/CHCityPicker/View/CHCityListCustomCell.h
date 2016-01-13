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
*  创建cell并给子控件赋值
*
*  @param array 给定数组
*
*  @return cell
*/
+ (instancetype)cellWithCityNames:(NSArray<NSString *> *)array;

/**
 *  配置Cell按钮的标题
 */
- (void)configCellTitle;
@end
