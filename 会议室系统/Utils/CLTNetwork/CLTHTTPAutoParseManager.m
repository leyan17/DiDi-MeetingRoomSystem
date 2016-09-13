//
//  CLTHTTPAutoParseManager.m
//  camelot
//
//  Created by 刘春侠 on 15/12/3.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "CLTHTTPAutoParseManager.h"
#import <JSONModel.h>
typedef void (^successBlock)(AFHTTPRequestOperation *operation , id obj);
typedef void (^failedBlock)(AFHTTPRequestOperation *operation , NSError *error);
@implementation CLTHTTPAutoParseManager
+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(CLTAutoParams *)parameters
                        successBlock:(void (^)(id obj))success
                        failureBlock:(void (^)(NSError *error))failure {
    
    successBlock sc =  ^(AFHTTPRequestOperation *operation,id obj) {
        Class class = NSClassFromString(parameters.className);
        NSError *error = nil;
        NSAssert([class isSubclassOfClass:[JSONModel class]], @"Model class is not subclass of JsonModel");
        id object = [[class alloc]initWithDictionary:obj error:&error];
        success(object);
    };
    failedBlock fail = ^(AFHTTPRequestOperation *operation,NSError *error) {
        failure(error);
    };
    return [super GET:URLString parameters:parameters.params success:[sc copy] failure:[fail copy]];
}

+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                     parameters:(CLTAutoParams *)parameters
                   successBlock:(void (^)(id obj))success
                   failureBlock:(void (^)(NSError *error))failure {
    
    successBlock sc =  ^(AFHTTPRequestOperation *operation,id obj) {
        Class class = NSClassFromString(parameters.className);
        NSError *error = nil;
        id object = nil;
        NSAssert([class isSubclassOfClass:[JSONModel class]], @"Model class is not subclass of JsonModel");
        if ([obj isKindOfClass:[NSData class]]) {
            object = [[class alloc]initWithData:obj error:&error];
        }else if ([obj isKindOfClass:[NSDictionary class]]) {
             object= [[class alloc]initWithDictionary:obj error:&error];
        }
        if (!error) {
            NSLog(@"json error: errorMessage:%@",[error localizedDescription]);
            success(object);
        }else {
            success(nil);
        }
    };
    failedBlock fail = ^(AFHTTPRequestOperation *operation,NSError *error) {
        failure(error);
    };
    return [super POST:URLString parameters:parameters.params success:[sc copy] failure:[fail copy]];
}
@end

@implementation CLTAutoParams

+ (CLTAutoParams *)autoParamsWithClassName:(NSString *)className params:(NSDictionary *)dict {
    CLTAutoParams *param = [[CLTAutoParams alloc]init];
    param.className = className;
    param.params = [dict copy];
    return param;
}

@end
