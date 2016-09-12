//
//  NSString+Separator.h
//  
//
//  Created by 刘春侠 on 15/10/26.
//  Copyright © 2015年 reddick. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Separator)
/**
 *  string 如 "a=b&c=d&e=f" -> NSDictionary {a:b,c:d,e,f}
 *
 *  @param separateChar 分隔符
 *
 *  @return dictionary
 */
- (NSDictionary *)componentSeparatedByCharacter:(NSString *)separateChar;

/**
 *
 *  string to array 去除掉分隔符和空字符串
 *  @param seperator 分隔符
 *
 *  @return
 */
- (NSArray *)toArrayBy:(NSString *)seperator;

+ (instancetype)fromArray:(NSArray *)array;
@end
