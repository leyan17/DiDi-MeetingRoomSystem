//
//  CLTUncaughtExceptionHandler.m
//  
//
//  Created by 刘春侠 on 15/12/8.
//  Copyright © 2015年 camelot. All rights reserved.
//
#import "CLTUncaughtExceptionHandler.h"
NSString const *fileName = @"Exception";

NSString *applicationDocumentsDirectory() {
    return [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
}

NSString  *exceptionFilePath() {
    return [applicationDocumentsDirectory() stringByAppendingPathComponent:[fileName copy]];
}

void CLT_UncaughtExceptionHandler(NSException *exception) {
    NSArray *arr = [exception callStackSymbols];
    NSString *reason = [exception reason];
    NSString *name = [exception name];
    
    NSString *url = [NSString stringWithFormat:@"=============异常崩溃报告=============\nname:\n%@\nreason:\n%@\ncallStackSymbols:\n%@",
                     name,reason,[arr componentsJoinedByString:@"\n"]];

    [url writeToFile:exceptionFilePath() atomically:YES encoding:NSUTF8StringEncoding error:nil];
}


@implementation CLTUncaughtExceptionHandler
-(NSString *)applicationDocumentsDirectory {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
}

+ (void)setDefaultHandler {
    NSSetUncaughtExceptionHandler (&CLT_UncaughtExceptionHandler);
}

+ (NSUncaughtExceptionHandler*)getHandler {
    return NSGetUncaughtExceptionHandler();
}


@end


