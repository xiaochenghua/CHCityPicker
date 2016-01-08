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
 *
 *  @return 返回Cell
 */
- (instancetype)initWithCityListCellType:(CHCityListCellType)type array:(NSArray *)array;

@end
