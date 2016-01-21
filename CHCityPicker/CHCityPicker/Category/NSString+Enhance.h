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
 *  根据JSON文件名，返回文件内容
 *
 *  @param fileName 文件名
 *  @param type     文件扩展名，@"json"
 *
 *  @return 文件内容
 */
+ (NSString *)stringWithFileName:(NSString *)fileName type:(NSString *)type;

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
