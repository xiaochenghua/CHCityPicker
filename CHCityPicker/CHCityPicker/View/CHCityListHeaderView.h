//
//  CHCityListHeaderView.h
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/12.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CHCityListHeaderView : UIView
/**
 *  默认的类方法
 *
 *  @return CHCityListHeaderView
 */
+ (instancetype)headerView;

/**
 *  配置标题
 *
 *  @param title 标题
 */
- (void)configTitle:(NSString *)title;

@end
