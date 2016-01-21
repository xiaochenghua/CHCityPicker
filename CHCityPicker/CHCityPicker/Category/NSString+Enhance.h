//
//  NSString+Enhance.h
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/8.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Enhance)

/**
 *  ASCII码数值 --> 字符 --> 字符串，默认大写
 *
 *  @param number    ASCII码数值
 *
 *  @return 字符串
 */
+ (NSString *)stringwithInt:(int)number;

/**
 *  获取索引字母，默认大写
 */
- (NSString *)capital;

@end
