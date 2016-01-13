//
//  CHCityListHeaderView.m
//  CHCityPicker
//
//  Created by APP on 16/1/12.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityListHeaderView.h"

@interface CHCityListHeaderView ()
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) UILabel     *titleLabel;
@end

@implementation CHCityListHeaderView

+ (instancetype)headerViewWithStyle:(HeaderViewStyle)style {
    return [[self alloc] initWithHeaderViewStyle:style];
}

- (instancetype)initWithHeaderViewStyle:(HeaderViewStyle)style {
    if (self = [super init]) {
        if (style == HeaderViewStyleSection) {
            self.backgroundColor = kColor(grayColor);
            [self setupTitleLabel];
        } else if (style == HeaderViewStyleTableView) {
            [self setupSearchBar];
        }
    }
    return self;
}

- (void)setupTitleLabel {
    [self addSubview:self.titleLabel];
    [self.titleLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:20];
    [self.titleLabel autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)setupSearchBar {
    [self addSubview:self.searchBar];
    
    [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.searchBar autoPinEdgeToSuperviewEdge:ALEdgeTop];
}

- (void)configTitle:(NSString *)title {
    self.titleLabel.text = title;
}

#pragma mark - Lazy Loading
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.placeholder = @"城市/行政区/拼音";
    }
    return _searchBar;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:15];
        _titleLabel.textColor = kColorValueWithRGB(0.41, 0.41, 0.41);
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

@end
