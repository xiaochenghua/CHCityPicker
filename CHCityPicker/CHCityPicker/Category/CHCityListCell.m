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
    /**
     *  Cell类型
     */
    CHCityListCellType cellType;
    
    /**
     *  默认列，——3
     */
    NSUInteger defaultCol;
    
    /**
     *  X、Y轴间距
     */
    CGFloat marginX, marginY;
    
    /**
     *  contentView的宽度
     */
    CGFloat selfWidth;
    
    /**
     *  按钮的宽、高
     */
    CGFloat btnWidth, btnHeight;
    
    /**
     *  城市按钮数组
     */
    NSArray<UIButton *> *cityArray;
}

/**
 *  城市按钮
 */
@property (nonatomic, strong) UIButton *cityNameButton;

@end

@implementation CHCityListCell

- (instancetype)initWithCityArray:(NSArray *)array identifier:(NSString *)identifier type:(CHCityListCellType)type {
    if (self = [super init]) {
        cityArray = array;
        cellType = type;
        [self initDefaultValue];
        [self addButtonWithArray:array];
    }
    return self;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier type:(CHCityListCellType)type {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        cellType = type;
    }
    return self;
}

- (void)initDefaultValue {
    defaultCol = 3;
    marginX = 20.0f;
    marginY = 15.0f;
    selfWidth = self.contentView.bounds.size.width;
    btnWidth = (selfWidth - marginX * 5) / 3;
    btnHeight = 40.0f;
}

- (void)addButtonWithArray:(NSArray *)array {
    for (NSUInteger i = 0; i < array.count; i++) {
        [self.contentView addSubview:self.cityNameButton];
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
//    [self.cityNameButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:leftInset];
    [self.cityNameButton autoPinEdge:ALEdgeLeft toEdge:ALEdgeLeft ofView:self withOffset:leftInset];
//    [self.cityNameButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:topInset];
    [self.cityNameButton autoPinEdge:ALEdgeTop toEdge:ALEdgeTop ofView:self withOffset:topInset];
    [self.cityNameButton autoSetDimensionsToSize:CGSizeMake(btnWidth, btnHeight)];
}

- (void)setCellSystemTitle:(NSString *)title type:(CHCityListCellType)type {
    if (type == CHCityListCellTypeSystem) {
        self.textLabel.text = title;
    }
}

- (void)setCellCustomTitleArray:(NSArray *)array type:(CHCityListCellType)type {
    if (type == CHCityListCellTypeButton) {
        for (int i = 0; i < array.count; i++) {
            if ([self.contentView.subviews[i] isKindOfClass:[UIButton class]]) {
//                self.cityNameButton.titleLabel.text = array[i];
                [self.cityNameButton setTitle:array[i] forState:UIControlStateNormal];
            } else {
                NSLog(@"error：Cell子控件不是UIButton");
            }
        }
    }
}

- (CGFloat)calcRowHeight {
    if (cellType == CHCityListCellTypeSystem) {
        return 44;
    } else if (cellType == CHCityListCellTypeButton) {
        NSUInteger index = cityArray.count - 1;
        return CGRectGetMaxY(cityArray[index].frame) + marginY;
    } else {
        return 0;
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
