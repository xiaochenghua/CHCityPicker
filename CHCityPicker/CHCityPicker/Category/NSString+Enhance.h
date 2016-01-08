//
//  NSString+Enhance.h
//  CHCityPicker
//
//  Created by APP on 16/1/8.
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
 *  ASCII码数值 --> 字符 --> 字符串
 *
 *  @param number    ASCII码数值
 *  @param needUpper 是否需要转换成大写
 *
 *  @return 字符串
 */
+ (NSString *)stringwithInt:(int)number needUpper:(BOOL)needUpper;

/**
 *  返回字符串指定下标的字符对应的ASCII码数值
 *
 *  @param needUpper 是否需要转换成大写
 *
 *  @return ASCII码数值
 */
- (int)asciiNeedUpper:(BOOL)needUpper;
/**
 *  返回字符串的首字母
 *
 *  @param needUpper 是否需要转换成大写
 *
 *  @return 字符串形式首字母
 */
- (NSString *)capitalNeedUpper:(BOOL)needUpper;

@end
