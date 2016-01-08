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

/**
 *  根据CHCityListCellType初始化Cell
 *
 *  @param type CHCityListCellType
 *  @param array 需要初始化的按钮数组
 *  @param identifier 
 *
 *  @return 返回Cell
 */
- (instancetype)initWithCityListCellType:(CHCityListCellType)type array:(NSArray *)array identifier:(NSString *)identifier;

/**
 *  设置Cell的标题，按钮或标签标题文字
 *
 *  @param title 文字，可为nil
 *  @param array 按钮名称数组，可为nil
 *  @param type  类型，按钮/标签
 */
- (void)setCellTitle:(NSString *)title array:(NSArray *)array type:(CHCityListCellType)type;
@end
