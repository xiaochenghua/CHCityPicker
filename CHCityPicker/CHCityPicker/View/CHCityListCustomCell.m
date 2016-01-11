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
    CGFloat contentViewWidth;
    CGFloat marginX, marginY;
    CGFloat btnWidth, btnHeight;
    NSArray<NSString *> *cityNames;
    NSMutableArray<CHCityButton *> *cityButtons;
}

@end

@implementation CHCityListCustomCell

- (instancetype)initWithCityNames:(NSArray<NSString *> *)array {
    if (self = [super init]) {
        self.cityListCellType = CHCityListCellTypeCustom;
        cityNames = [NSArray arrayWithArray:array];
        cityButtons = [NSMutableArray arrayWithCapacity:cityNames.count];
        [self initDefaultData];
        [self setupSubViewsWithCityNames:array];
    }
    return self;
}

- (void)initDefaultData {
    defaultCol = 3;
    contentViewWidth = self.contentView.bounds.size.width;
    marginX = 20.0f;
    marginY = 15.0f;
    btnWidth = (contentViewWidth - marginX * 5) / 3;
    btnHeight = 40.0f;
}

- (void)setupSubViewsWithCityNames:(NSArray<NSString *> *)array {
    for (int i = 0; i < array.count; i++) {
        CHCityButton *btn = [[CHCityButton alloc] init];
        [self.contentView addSubview:btn];
        [cityButtons addObject:btn];
        [self setupLayoutWithButton:btn index:i];
    }
}

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

- (CGFloat)calcRowHeight {
    return CGRectGetMaxY([cityButtons lastObject].frame) + marginY;
}
@end
