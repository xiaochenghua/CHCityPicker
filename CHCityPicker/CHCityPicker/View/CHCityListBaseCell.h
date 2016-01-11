//
//  CHCityListBaseCell.h
//  CHCityPicker
//
//  Created by APP on 16/1/11.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CHCityListCellType) {
    CHCityListCellTypeCustom,
    CHCityListCellTypeSystem
};

@interface CHCityListBaseCell : UITableViewCell

/**
 *  cityListCellType
 */
@property (nonatomic, assign) CHCityListCellType cityListCellType;

/**
 *  行高
 */
@property (nonatomic, assign) CGFloat rowHeight;

/**
 *  计算行高
 *
 *  @return 行高
 */
- (CGFloat)calcRowHeight;

@end
