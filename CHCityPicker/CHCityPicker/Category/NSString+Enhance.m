//
//  NSString+Enhance.m
//  CHCityPicker
//
//  Created by arnoldxiao on 16/1/8.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "NSString+Enhance.h"

@implementation NSString (Enhance)

+ (NSString *)stringWithFileName:(NSString *)fileName type:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSError *error = nil;
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
}

+ (NSString *)stringwithInt:(int)number {
    return [self stringwithInt:number needUpper:YES];
}

+ (NSString *)stringwithInt:(int)number needUpper:(BOOL)needUpper {
    const unichar c = number;
    NSString *tmpString = [self stringWithCharacters:&c length:1];
    return needUpper ? [tmpString uppercaseString] : [tmpString lowercaseString];
}

- (NSString *)capital {
    return [self capitalNeedUpper:YES];
}

- (NSString *)capitalNeedUpper:(BOOL)needUpper {
    NSUInteger index = 0;
    if ([self containsString:@"_"]) {
        NSRange range = [self rangeOfString:@"_"];
        index = range.location + 1;
    }
    NSString *tmpString = [self substringWithRange:NSMakeRange(index, 1)];
    return needUpper ? [tmpString uppercaseString] : [tmpString lowercaseString];
}

@end
