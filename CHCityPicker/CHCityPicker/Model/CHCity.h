//
//  CHCity.h
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/13.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface CHCity : JSONModel
@property (nonatomic, assign) long cityID;
@property (nonatomic, copy) NSString *cityName;
@property (nonatomic, copy) NSString *pinyin;
@end
