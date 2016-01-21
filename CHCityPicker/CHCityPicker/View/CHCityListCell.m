//
//  CHCityListCell.m
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/19.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityListCell.h"
#import "CHCityButton.h"

@interface CHCityListCell ()
{
    NSUInteger defaultCol;
    CGFloat btnWidth, btnHeight;
    NSArray<NSString *> *cityNames;
    NSMutableArray<CHCityButton *> *cityButtons;
}
@end

static const CGFloat margin = 12.0f;

@implementation CHCityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier cityNames:(NSArray<NSString *> *)array {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        cityNames = [NSArray arrayWithArray:array];
        cityButtons = [NSMutableArray arrayWithCapacity:cityNames.count];
        [self initSomeDefaultData];
        [self setupSubViewsWithCityNames:array];
        self.rowHeight = (btnHeight + margin) * ((cityButtons.count - 1) / defaultCol) + margin * 2 + btnHeight;
        self.backgroundColor = kColorCodeWithRGB(0xf0f0f0);
    }
    return self;
}

- (void)setupSubViewsWithCityNames:(NSArray<NSString *> *)array {
    for (int i = 0; i < array.count; i++) {
        CHCityButton *btn = [[CHCityButton alloc] init];
        [self.contentView addSubview:btn];
        [cityButtons addObject:btn];
        [self setupLayoutWithButton:btn index:i];
    }
}

- (void)initSomeDefaultData {
    defaultCol = 3;
    btnWidth   = ([[UIScreen mainScreen] applicationFrame].size.width - marginX * 5) / 3;
    btnHeight  = 30.0f;
}

- (void)setupLayoutWithButton:(UIButton *)btn index:(NSUInteger)index {
    NSUInteger row    = index / defaultCol;
    NSUInteger col    = index % defaultCol;

    CGFloat leftInset = (btnWidth + marginX) * col + marginX;
    CGFloat topInset  = (btnHeight + margin) * row + margin;
    
    [btn autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:leftInset];
    [btn autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:topInset];
    [btn autoSetDimensionsToSize:CGSizeMake(btnWidth, btnHeight)];
}

- (void)configTitleForCellSubView {
    for (int i = 0; i < cityNames.count; i++) {
        [cityButtons[i] setTitle:cityNames[i] forState:UIControlStateNormal];
    }
}

@end
