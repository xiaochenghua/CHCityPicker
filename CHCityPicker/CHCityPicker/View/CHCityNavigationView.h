//
//  CHCityNavigationView.h
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/14.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCityNavigationView : UIView

+ (instancetype)navigationViewWithButtonArray:(NSArray *)array;

- (CGSize)calcNavigationViewSizeWithButtonArray:(NSArray *)array;

@end
