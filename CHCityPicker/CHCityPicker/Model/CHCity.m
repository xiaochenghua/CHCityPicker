//
//  CHCity.m
//  CHCityPicker
//
//  Created by APP on 16/1/8.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCity.h"

@implementation CHCity

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        _city_id = [[dict objectForKey:@"id"] longValue];
        _cityName = [dict objectForKey:@"city"];
        _pinyin = [dict objectForKey:@"pinyin"];
        _selectedTimes = 0;                             //  初始化选中次数为0
    }
    return self;
}

@end
