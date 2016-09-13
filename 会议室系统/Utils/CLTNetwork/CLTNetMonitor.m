//
//  CLTNetMonitor.m
//  
//
//  Created by 刘春侠 on 15/11/25.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "CLTNetMonitor.h"
#import <Reachability.h>


NSString *const CLTNetworkDomain = @"www.baidu.com";
static CLTNetMonitor *_manager = nil;

@interface CLTNetMonitor ()
@property (nonatomic, strong)Reachability *reach;
@end
@implementation CLTNetMonitor
+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[self alloc]init];
    });
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
       
    }
    return self;
}

- (Reachability *)reach {
    if (_reach == nil) {
        _reach = [Reachability reachabilityWithHostName:CLTNetworkDomain];
        [_reach setReachableBlock:^(Reachability *reach){
          DDLogVerbose(@"%@",[reach debugDescription]);
        }];
        
        [_reach setUnreachableBlock:^(Reachability *reach){
            DDLogVerbose(@"%@",[reach debugDescription]);
        }];
    }
    return _reach;
}

- (void)startMonitorNetwork {
    
    [self.reach startNotifier];
}

- (BOOL)isReachableViaWiFi {
    return [self.reach isReachableViaWiFi];
}

- (BOOL)isReachable {
    return [self.reach isReachable];
}

- (void)stopMonitorNetwork {
    [[self reach] stopNotifier];
}

- (void)networkChanged:(NSNotification *)not {
    
}


@end


@implementation Reachability (face)

- (NSString *)debugDescription {
    return [NSString stringWithFormat:@"%@ \n %@",[self isReachableViaWiFi]?@"wifi可用":@"无wifi",[self isReachable]?@"网络连接正常":@"无网络连接"];
}

@end

