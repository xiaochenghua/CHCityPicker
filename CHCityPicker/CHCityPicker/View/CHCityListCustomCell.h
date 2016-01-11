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
- (instancetype)initWithCityNames:(NSArray<NSString *> *)array;
- (void)configCellTitle;
- (CGFloat)calcRowHeight;
@end
