//
//  CHCityListCustomCell.m
//  CHCityPicker
//
//  Created by APP on 16/1/11.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityListCustomCell.h"
#import "CHCityButton.h"

@interface CHCityListCustomCell ()
{
    NSUInteger defaultCol;
    CGFloat marginX, marginY;
    CGFloat btnWidth, btnHeight;
    NSArray<NSString *> *cityNames;
    NSMutableArray<CHCityButton *> *cityButtons;
}

@end

@implementation CHCityListCustomCell

+ (instancetype)cellWithCityNames:(NSArray<NSString *> *)array {
    return [[self alloc] initWithCityNames:array];
}

- (instancetype)initWithCityNames:(NSArray<NSString *> *)array {
    if (self = [super init]) {
        cityNames = [NSArray arrayWithArray:array];
        cityButtons = [NSMutableArray arrayWithCapacity:cityNames.count];
        [self initDefaultData];
        [self setupSubViewsWithCityNames:array];
        self.cityListCellType = CHCityListCellTypeCustom;
        self.rowHeight = (btnHeight + marginY) * ((cityButtons.count - 1) / defaultCol) + marginY * 2 + btnHeight;
        self.backgroundColor = kColorCodeWithRGB(0xf0f0f0);
    }
    return self;
}

/**
 *  初始化默认数据
 */
- (void)initDefaultData {
    defaultCol = 3;
    marginX = 20.0f;
    marginY = 12.0f;
    btnWidth = ([[UIScreen mainScreen] applicationFrame].size.width - marginX * 5) / 3;
    btnHeight = 38.0f;
}

/**
 *  设置子控件
 *
 *  @param array 给定数组
 */
- (void)setupSubViewsWithCityNames:(NSArray<NSString *> *)array {
    for (int i = 0; i < array.count; i++) {
        CHCityButton *btn = [[CHCityButton alloc] init];
        [self.contentView addSubview:btn];
        [cityButtons addObject:btn];
        [self setupLayoutWithButton:btn index:i];
    }
}

/**
 *  自动布局
 *
 *  @param btn   布局的控件
 *  @param index 索引值，下标
 */
- (void)setupLayoutWithButton:(UIButton *)btn index:(NSUInteger)index {
    NSUInteger row = index / defaultCol;
    NSUInteger col = index % defaultCol;
    
    CGFloat leftInset = (btnWidth + marginX) * col + marginX;
    CGFloat topInset = (btnHeight + marginY) * row + marginY;
    
    [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:leftInset];
    [btn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:topInset];
    [btn autoSetDimensionsToSize:CGSizeMake(btnWidth, btnHeight)];
}

- (void)configCellTitle {
    for (int i = 0; i < cityNames.count; i++) {
        [cityButtons[i] setTitle:cityNames[i] forState:UIControlStateNormal];
    }
}
@end
