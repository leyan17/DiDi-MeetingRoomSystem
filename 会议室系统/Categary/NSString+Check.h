//
//  NSString+Check.h
//  
//
//  Created by 刘春侠 on 15/12/5.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Check)
/**
 *  判断是否为空string和只有空格的字符串
 *
 *  @return
 */
- (BOOL)isEmpty;

/**
 *  判断是否为电话号码
 *
 *  @return
 */
- (BOOL)isPhoneNumber;

@end

/**
 *  emoji表情
 */
@interface NSString (Emoji)

- (BOOL)isIncludingEmoji;

- (instancetype)removedEmojiString;

+ (BOOL)stringContainsEmoji:(NSString *)string;

@end

