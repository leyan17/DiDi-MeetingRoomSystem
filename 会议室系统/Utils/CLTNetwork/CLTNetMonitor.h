//
//  CLTNetMonitor.h
//  meituan
//
//  Created by 刘春侠 on 15/11/25.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  网络状态监测
 */
@interface CLTNetMonitor : NSObject
FOUNDATION_EXPORT NSString *const AFNetworkingReachabilityDidChangeNotification;
FOUNDATION_EXPORT NSString *const AFNetworkingReachabilityNotificationStatusItem;

@property (readonly, nonatomic, assign, getter = isReachable) BOOL reachable;
@property (readonly, nonatomic, assign, getter = isReachableViaWiFi) BOOL reachableViaWiFi;

+ (instancetype)sharedManager;

- (void)startMonitorNetwork;

- (void)stopMonitorNetwork;
@end
