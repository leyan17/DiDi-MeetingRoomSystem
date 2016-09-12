//
//  NSString+Separator.m
//
//
//  Created by 刘春侠 on 15/10/26.
//  Copyright © 2015年 reddick. All rights reserved.
//

#import "NSString+Separator.h"

@implementation NSString (Separator)
- (NSDictionary *)componentSeparatedByCharacter:(NSString *)separateChar {
    NSArray *arrayTmp = [self componentsSeparatedByString:separateChar];
    NSMutableDictionary *results = [[NSMutableDictionary alloc]initWithCapacity:[arrayTmp count]];

    for (NSString *obj in arrayTmp) {
        NSArray *keyValues = [obj componentsSeparatedByString:@"="];
        NSString *key = keyValues[0];
        NSString *value = keyValues[1];
        [results setValue:value forKey:key];
    }
    return results;
}

- (NSArray *)toArrayBy:(NSString *)seperator {
    NSMutableArray *mutableArray = [NSMutableArray array];
    NSArray *array = [self componentsSeparatedByString:seperator];
    
    for (NSInteger i = 0; i < array.count; ++i) {
        NSString *string = array[i];
        if (string.length > 0) {
            [mutableArray addObject:string];
        }
    }
    
    return mutableArray;
}

+ (instancetype)fromArray:(NSArray *)array {
    if ([array isKindOfClass:[NSString class]]) {
        
        return (NSString *)array;
    } else if (![array isKindOfClass:[NSArray class]]) {
        return [[NSString alloc] initWithFormat:@"%@", array];
    }
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSInteger i = 0; i < array.count; ++i) {
        if (i == 0) {
            [string appendFormat:@"%@", array[i]];
        } else {
            [string appendFormat:@",%@", array[i]];
        }
    }
    
    return string;
}
@end
