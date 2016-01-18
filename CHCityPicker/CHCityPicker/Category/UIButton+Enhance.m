//
//  UIButton+Enhance.m
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/18.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "UIButton+Enhance.h"
#import "CHCityPickerController.h"

@implementation UIButton (Enhance)

- (CHCityPickerController *)controller {
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isMemberOfClass:[CHCityPickerController class]]) {
            return (CHCityPickerController *)nextResponder;
        }
    }
    return nil;
}

@end
