//
//  CLTHTTPAutoParseManager.h
//  camelot
//
//  Created by 刘春侠 on 15/12/3.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "CLTHTTPManager.h"
@class CLTAutoParams;
/**
 *  支持网络自解析(jsonModel自解析)
 */
@interface CLTHTTPAutoParseManager : CLTHTTPManager
+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(CLTAutoParams *)parameters
                   successBlock:(void (^)(id obj))success
                   failureBlock:(void (^)(NSError *error))failure;

+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(CLTAutoParams *)parameters
                    successBlock:(void (^)(id obj))success
                    failureBlock:(void (^)(NSError *error))failure;
@end

/**
 *  自解析参数 传入需要解析的类名 和 参数
 */
@interface CLTAutoParams : NSObject
@property (nonatomic, copy)NSString *className;
@property (nonatomic, copy)NSDictionary *params;

+ (CLTAutoParams *)autoParamsWithClassName:(NSString *)className params:(NSDictionary *)dict;
@end