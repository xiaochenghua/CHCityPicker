//
//  UIButton+Enhance.h
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/18.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CHCityPickerController;

@interface UIButton (Enhance)

/**
 *  找到下一个为CHCityPickerController响应者
 */
- (CHCityPickerController *)controller;

@end
