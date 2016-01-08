//
//  NSString+Enhance.m
//  CHCityPicker
//
//  Created by APP on 16/1/8.
//  Copyright © 2016年 Personal. All rights reserved.
//

#import "NSString+Enhance.h"

@implementation NSString (Enhance)

+ (NSString *)stringWithFileName:(NSString *)fileName type:(NSString *)type {
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    NSError *error = nil;
    return [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:&error];
}

+ (NSString *)stringwithInt:(int)number needUpper:(BOOL)needUpper {
    const unichar c = number;
    NSString *tmpString = [self stringWithCharacters:&c length:1];
    return needUpper ? [tmpString uppercaseString] : [tmpString lowercaseString];
}

- (int)asciiNeedUpper:(BOOL)needUpper {
    
    NSUInteger index = 0;
    
    if ([self containsString:@"_"]) {
        NSRange tmpRange = [self rangeOfString:@"_"];
        index = tmpRange.location + 1;
    }
    
    NSString *tmpString = [self capitalNeedUpper:needUpper];
    return [tmpString characterAtIndex:index];
}

- (NSString *)capitalNeedUpper:(BOOL)needUpper {
    NSString *tmpString = needUpper ? [self uppercaseString] : [self lowercaseString];
    return [tmpString substringToIndex:1];
}

@end
