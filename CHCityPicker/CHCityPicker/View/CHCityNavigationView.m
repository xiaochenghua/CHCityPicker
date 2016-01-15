//
//  CHCityNavigationView.m
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/14.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCityNavigationView.h"
#import "CHButton.h"
#import "NSString+Enhance.h"

@interface CHCityNavigationView ()
{
    CGFloat margin;
}
@end

static const CGFloat topInset = 75.0f;

@implementation CHCityNavigationView

+ (instancetype)navigationViewWithButtonArray:(NSArray *)array {
    return [[self alloc] initWithButtonArray:array];
}

- (instancetype)initWithButtonArray:(NSArray *)array {
    if (self = [super init]) {
        [self setupLayoutWithButtonArray:array];
    }
    return self;
}

- (void)setupLayoutWithButtonArray:(NSArray *)array {
    margin = (kScreenHeight - 64 - array.count * buttonHeight - 2 * topInset) / (array.count - 1);
    for (int i = 0; i < array.count; i++) {
        CHButton *capitalButton = [CHButton button];
        
        [self addSubview:capitalButton];
        
        [capitalButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [capitalButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:topInset + (buttonHeight + margin) * i];
        [capitalButton autoSetDimensionsToSize:CGSizeMake(buttonWidth, buttonHeight)];
                
        [capitalButton setTitle:array[i] forState:UIControlStateNormal];
    }
}
@end
