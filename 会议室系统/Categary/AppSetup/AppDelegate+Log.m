//
//  AppDelegate+Log.m
//  camelot
//
//  Created by 刘春侠 on 15/12/8.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "AppDelegate+Log.h"

@implementation AppDelegate (Log)
- (void)setUpCocoaLumberJack {
    setenv("XcodeColors","YES",0);
    [DDLog addLogger:[DDTTYLogger sharedInstance]]; // TTY = Xcode console
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];// 启用颜色区分
    [DDLog addLogger:[DDASLLogger sharedInstance]]; // ASL = Apple System Logs
    DDFileLogger *fileLogger = [[DDFileLogger alloc] init]; // File Logger
    fileLogger.rollingFrequency = 60 * 60 * 24; // 24 hour rolling
    fileLogger.logFileManager.maximumNumberOfLogFiles = 100;
    [DDLog addLogger:fileLogger];
    DDLogVerbose(@"log start success");
}
@end
