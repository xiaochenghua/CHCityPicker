//
//  CHCityListCell.h
//  CHCityPicker
//
//  Created by APP on 16/1/8.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CHCityListCellType) {
    CHCityListCellTypeButton,
    CHCityListCellTypeSystem
};

@interface CHCityListCell : UITableViewCell

- (instancetype)initWithCityArray:(NSArray *)array identifier:(NSString *)identifier type:(CHCityListCellType)type;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CHCityListCellType)type;

/**
 *  设置系统Default样式Cell的标题
 *
 *  @param title 标题
 *  @param type  样式，CHCityListCellTypeSystem
 */
- (void)setCellSystemTitle:(NSString *)title type:(CHCityListCellType)type;

/**
 *  设置按钮样式Cell，按钮标题为array[i]
 *
 *  @param array 按钮标题数组
 *  @param type  样式，CHCityListCellTypeButton
 */
- (void)setCellCustomTitleArray:(NSArray *)array type:(CHCityListCellType)type;

/**
 *  计算行高
 *
 *  @return 行高
 */
- (CGFloat)calcRowHeight;
@end
