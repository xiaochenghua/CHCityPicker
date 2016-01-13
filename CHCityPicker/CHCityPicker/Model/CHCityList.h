//
//  CHCityList.h
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/13.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@class CHCity;

@interface CHCityList : JSONModel
@property (nonatomic, copy) NSArray<CHCity *> *citys;
@end
