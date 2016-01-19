//
//  CHCityButton.m
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/11.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityButton.h"
#import "UIButton+Enhance.h"

@implementation CHCityButton

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = kColor(whiteColor);
        self.titleLabel.font = kFont(15);
        [self setTitleColor:kColorCodeWithRGB(0x8e8e8e) forState:UIControlStateNormal];
        self.layer.cornerRadius = 2.0f;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = kColorCodeWithRGB(0xd0d0d0).CGColor;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        [self addTarget:[self controller] action:@selector(cityButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
#pragma clang diagnostic pop
    }
    return self;
}

@end
