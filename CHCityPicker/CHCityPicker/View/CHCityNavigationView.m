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
//@property (nonatomic, strong) CHButton *capitalButton;
@end

static const CGFloat margin = 3.0f;

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
    for (int i = 0; i < array.count; i++) {
        CHButton *capitalButton = [CHButton button];
        
        [self addSubview:capitalButton];
        
        [capitalButton autoPinEdgeToSuperviewEdge:ALEdgeLeft];
        [capitalButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:(buttonHeight + margin) * i];
        [capitalButton autoSetDimensionsToSize:CGSizeMake(buttonWidth, buttonHeight)];
                
        [capitalButton setTitle:array[i] forState:UIControlStateNormal];
    }
}

- (CGSize)calcNavigationViewSizeWithButtonArray:(NSArray *)array {
    CGFloat selfHeight = buttonHeight + (array.count - 1) * (buttonHeight + margin);
    return CGSizeMake(buttonWidth, selfHeight);
}

@end
