//
//  CHCityButton.m
//  CHCityPicker
//
//  Created by APP on 16/1/11.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityButton.h"

@implementation CHCityButton

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = kColor(whiteColor);
        self.titleLabel.font = kFont(12);
        self.titleLabel.textColor = kColorADADAD;
        self.layer.cornerRadius = 2.0f;
        self.layer.masksToBounds = YES;
        self.layer.borderWidth = 0.5f;
        self.layer.borderColor = kColorD0D0D0.CGColor;
    }
    return self;
}

@end
