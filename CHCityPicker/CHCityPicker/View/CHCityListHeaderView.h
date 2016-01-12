//
//  CHCityListHeaderView.h
//  CHCityPicker
//
//  Created by APP on 16/1/12.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, HeaderViewStyle) {
    HeaderViewStyleSection,
    HeaderViewStyleTableView
};

@interface CHCityListHeaderView : UIView
- (instancetype)initWithHeaderViewStyle:(HeaderViewStyle)style;
- (void)configTitle:(NSString *)title;
@end
