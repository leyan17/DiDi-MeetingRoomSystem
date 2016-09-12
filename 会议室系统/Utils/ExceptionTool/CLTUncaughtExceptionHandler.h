//
//  CLTUncaughtExceptionHandler.h
//
//
//  Created by 刘春侠 on 15/12/8.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString* exceptionFilePath();
@interface CLTUncaughtExceptionHandler : NSObject
/**
 *  创建崩溃句柄环境 在appdelegate中调用即可
 */
+ (void)setDefaultHandler;

+ (NSUncaughtExceptionHandler*)getHandler;
@end
