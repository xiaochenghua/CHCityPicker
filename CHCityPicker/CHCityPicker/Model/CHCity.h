//
//  CHCity.h
//  CHCityPicker
//
//  Created by APP on 16/1/8.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CHCity : NSObject
@property (nonatomic, assign) long city_id;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *pinyin;

@property (nonatomic, assign) long selectedTimes;       //  选中次数，次数多的显示与热门城市中

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
