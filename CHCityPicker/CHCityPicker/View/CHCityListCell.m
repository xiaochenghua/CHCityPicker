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
}
@end

static const CGFloat margin = 12.0f;

@implementation CHCityListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = kColorCodeWithRGB(0xf0f0f0);
        [self initDefaultValues];
    }
    return self;
}

- (void)configCityListCellWithCityNames:(NSArray<NSString *> *)array {
    cityNames = [NSArray arrayWithArray:array];
    [self setupSubviewsWithCityNames:array];
    self.rowHeight = (btnHeight + margin) * ((cityNames.count - 1) / defaultCol) + margin * 2 + btnHeight;
}

- (void)setLocationCellSubviewWithTitle:(NSString *)title {
    for (CHCityButton *btn in self.contentView.subviews) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
}

- (void)setupSubviewsWithCityNames:(NSArray<NSString *> *)array {
    if (self.contentView.subviews) {
        for (CHCityButton *btn in self.contentView.subviews) {
            [btn removeFromSuperview];
        }
    }
    
    for (int i = 0; i < array.count; i++) {
        CHCityButton *btn = [[CHCityButton alloc] init];
        [self.contentView addSubview:btn];
        [btn setTitle:cityNames[i] forState:UIControlStateNormal];
        [self setupLayoutWithButton:btn index:i];
    }
}

- (void)initDefaultValues {
    defaultCol = 3;
    btnWidth   = ([[UIScreen mainScreen] applicationFrame].size.width - marginX * 5) / 3;
    btnHeight  = 32.0f;
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

@end
