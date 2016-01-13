//
//  CHCity.m
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/13.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "CHCity.h"

@implementation CHCity
+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                       @"id" : @"cityID",
                                                       @"city" : @"cityName"
                                                       }];
}
@end
