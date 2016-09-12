//
//  CLTHTTPManager.h
//  meituan
//
//  Created by 刘春侠 on 15/12/3.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>
typedef NS_ENUM(NSInteger,CLTHTTPMethod) {
    CLTHTTPMethodGet = 0,
    CLTHTTPMethodPost,
};//暂时未使用
@interface CLTHTTPManager : AFHTTPRequestOperationManager
/**
 *  GET请求获取网络数据
 *
 *  @param URLString  连接地址
 *  @param parameters 参数  dictionary
 *  @param success    成功时的回调函数 responseObj
 *  @param failure    请求失败的回调函数
 *
 *  @return 
 */
+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation * operation, id responseObj))success
                        failure:(void (^)(AFHTTPRequestOperation * opreation, NSError * error))failure ;

+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;


@end



@interface CLTSecurityClient : CLTHTTPManager
/**
 *  ssl认证登陆 使用同上
 *
 *  @return 带证书登陆
 */
+ (instancetype)securityClient;
@end


/**
 *  安全策略 https专用
 */
@interface RDSecurityPolicy : AFSecurityPolicy
+ (instancetype)customSecurityPolicy;
@property (nonatomic, assign) AFSSLPinningMode SSLPinningMode;
+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity
               andTrust:(SecTrustRef*)outTrust
         fromPKCS12Data:(NSData *)inPKCS12Data;

+ (NSData *)p12Data;
@end