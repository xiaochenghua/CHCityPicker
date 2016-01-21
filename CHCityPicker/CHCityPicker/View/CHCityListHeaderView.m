//
//  CHCityListHeaderView.m
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/12.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityListHeaderView.h"

@interface CHCityListHeaderView ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation CHCityListHeaderView

+ (instancetype)headerView {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = kColorCodeWithRGB(0xe0e0e0);
        [self setupTitleLabel];
    }
    return self;
}

- (void)setupTitleLabel {
    [self addSubview:self.titleLabel];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:marginX];
    [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)configTitle:(NSString *)title {
    self.titleLabel.text = title;
}

#pragma mark - Lazy Loading
- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = kFontBold(15);
//        _titleLabel.textColor = kColorValueWithRGB(0.41, 0.41, 0.41);
        _titleLabel.textColor = kColorCodeWithRGB(0x6c6c6c);
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

@end
