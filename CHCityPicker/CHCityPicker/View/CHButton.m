//
//  CHButton.m
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/15.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHButton.h"
#import "UIButton+Enhance.h"

@implementation CHButton

+ (instancetype)button {
    return [[self alloc] init];
}

- (instancetype)init {
    if (self = [super init]) {
        [self setupLayout];
    }
    return self;
}

- (void)setupLayout {
    self.titleLabel.font = kFontBold(12);
    self.backgroundColor = kColor(whiteColor);
    [self setTitleColor:kColor(orangeColor) forState:UIControlStateNormal];
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    [self addTarget:[self controller] action:@selector(navigationButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
}

@end
