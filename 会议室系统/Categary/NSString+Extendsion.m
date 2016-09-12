//
//  NSString+Extendsion.m
//  
//
//  Created by 刘春侠 on 15/7/1.
//  Copyright (c) 2015年 TY. All rights reserved.
//

#import "NSString+Extendsion.h"

@implementation NSString (Extendsion)

/**
 *  返回字符串所需大小
 */
- (CGSize) sizeWithFont:(UIFont *)font
{
    return [self sizeWithFont:font maxW:MAXFLOAT];
}

/**
 *  返回字符串所需大小 指定宽度
 */
- (CGSize) sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW
{
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = font;
    return [self boundingRectWithSize:CGSizeMake(maxW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
