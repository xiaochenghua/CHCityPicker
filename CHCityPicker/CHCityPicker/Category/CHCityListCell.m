//
//  CHCityListCell.m
//  CHCityPicker
//
//  Created by APP on 16/1/8.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityListCell.h"

@interface CHCityListCell ()
{
    CHCityListCellType cellType;
    
    NSArray *buttonArray;
    NSUInteger buttonNumbers;
    
    NSUInteger defaultCol;
    CGFloat marginX, marginY;
    CGFloat selfWidth;
    CGFloat btnWidth, btnHeight;
}

@property (nonatomic, strong) UIButton *cityNameButton;

@end

@implementation CHCityListCell

- (instancetype)initWithCityListCellType:(CHCityListCellType)type array:(NSArray *)array identifier:(NSString *)identifier {
    if (self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier]) {
        cellType = type;
        if (cellType == CHCityListCellTypeButton) {
            buttonArray = array;
            buttonNumbers = array.count;
            [self initDefaultValue];
            [self addButtonWithArray:array];
        }
    }
    return self;
}

- (void)initDefaultValue {
    defaultCol = 3;
    marginX = 20.0f;
    marginY = 15.0f;
    selfWidth = self.bounds.size.width;
    btnWidth = (selfWidth - marginX * 5) / 3;
    btnHeight = 40.0f;
}

- (void)addButtonWithArray:(NSArray *)array {
    for (NSUInteger i = 0; i < buttonNumbers; i++) {
        [self addSubview:self.cityNameButton];
        self.cityNameButton.titleLabel.text = array[i];
        
        [self setupLayoutWithIndex:i];
    }
}

- (void)setupLayoutWithIndex:(NSUInteger)index {
    
    NSUInteger row = index / defaultCol;
    NSUInteger col = index % defaultCol;
    
    CGFloat leftInset = (btnWidth + marginX) * col + marginX;
    CGFloat topInset = (btnHeight + marginY) * row + marginY;
    
    //  cityNameButton - AutoLayout
    [self.cityNameButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:leftInset];
    [self.cityNameButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:topInset];
    [self.cityNameButton autoSetDimensionsToSize:CGSizeMake(btnWidth, btnHeight)];
}

- (void)setCellTitle:(NSString *)title array:(NSArray *)array type:(CHCityListCellType)type {
    if (type == CHCityListCellTypeSystem) {
        self.textLabel.text = title;
    } else if (type == CHCityListCellTypeButton) {
        for (int i = 0; i < self.subviews.count; i++) {
            if ([self.subviews[i] isKindOfClass:[UIButton class]]) {
                self.cityNameButton.titleLabel.text = array[i];
            } else {
                NSLog(@"error：Cell子控件不是UIButton");
            }
        }
    }
}

#pragma mark - 懒加载
- (UIButton *)cityNameButton {
    if (!_cityNameButton) {
        _cityNameButton = [[UIButton alloc] init];
        _cityNameButton.backgroundColor = kColor(whiteColor);
        _cityNameButton.titleLabel.font = kFont(12);
        _cityNameButton.titleLabel.textColor = kColorADADAD;
        _cityNameButton.layer.cornerRadius = 2.0f;
        _cityNameButton.layer.masksToBounds = YES;
        _cityNameButton.layer.borderWidth = 0.5f;
        _cityNameButton.layer.borderColor = kColorD0D0D0.CGColor;
    }
    return _cityNameButton;
}

@end
