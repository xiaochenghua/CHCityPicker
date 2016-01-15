//
//  CHCityNavigationView.h
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/14.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCityNavigationView : UIView
/**
 *  类方法 - 初始化导航视图
 *
 *  @param array 给定数组
 *
 *  @return 导航视图
 */
+ (instancetype)navigationViewWithButtonArray:(NSArray *)array;

@end
