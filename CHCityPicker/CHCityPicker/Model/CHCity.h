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

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
