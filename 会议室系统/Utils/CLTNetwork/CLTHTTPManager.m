//
//  CLTHTTPManager.m
//  meituan
//
//  Created by 刘春侠 on 15/12/3.
//  Copyright © 2015年 camelot. All rights reserved.
//

#import "CLTHTTPManager.h"
#import <AFNetworkActivityIndicatorManager.h>

/**
 *  p12Name https专用 bundle中p12文件名
 *  p12Key  https专用 p12证书的秘钥
 */
NSString *const p12Name = @"sslClient";
NSString *const p12Key = @"123456";


#define NetworkLog  NSLog(@"startRequest : {\
\n Method :%@ \
\n URL:%@ \
\n params:%@ }",method,URLString,parameters);
@implementation CLTHTTPManager
+ (void)initialize {
    [[AFNetworkActivityIndicatorManager sharedManager]setEnabled:YES];
}

+ (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation * operation, id responseObj))success
                        failure:(void (^)(AFHTTPRequestOperation * opreation, NSError * error))failure {
    return [[self manager]GET:URLString parameters:parameters success:success failure:failure];
}

+ (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *, id))success
                         failure:(void (^)(AFHTTPRequestOperation *, NSError *))failure {
    return [[self manager]POST:URLString parameters:parameters success:success failure:failure];
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {

    }
    return self;
}

- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(id)parameters
                        success:(void (^)(AFHTTPRequestOperation * operation, id responseObj))success
                        failure:(void (^)(AFHTTPRequestOperation * operation, NSError * error))failure {
    return [super GET:URLString parameters:parameters success:success failure:failure];
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(id)parameters
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithHTTPMethod:@"POST"
                                                                       URLString:URLString
                                                                      parameters:parameters
                                                                         success:success
                                                                         failure:failure];
    
    [self.operationQueue addOperation:operation];
    
    return operation;
}


- (AFHTTPRequestOperation *)HTTPRequestOperationWithHTTPMethod:(NSString *)method
                                                     URLString:(NSString *)URLString
                                                    parameters:(id)parameters
                                                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
#ifdef NetworkDebug
    NetworkLog
#endif
    NSError *serializationError = nil;
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:method URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters error:&serializationError];
    if (serializationError) {
        if (failure) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wgnu"
            dispatch_async(self.completionQueue ?: dispatch_get_main_queue(), ^{
                failure(nil, serializationError);
            });
#pragma clang diagnostic pop
        }
        
        return nil;
    }

    return [self HTTPRequestOperationWithRequest:request success:success failure:failure];
}

- (AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer {
    AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
    response.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                       @"text/json",
                                       @"text/javascript",
                                       @"text/html",
                                       @"text/plain",
                                       @"application/javascript",nil];
    
    return response;
}

@end



@implementation CLTSecurityClient

- (instancetype )initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        [self configSettings];
    }
    
    return self;
}

- (void)configSettings {
}

/**
 *  AF默认寻找bundle文件夹下的cer文件 此处使用p12文件自定制访问
 *
 *  @return
 */
+ (instancetype)securityClient {
    CLTSecurityClient *client = [[self alloc]initWithBaseURL:nil];
    client.securityPolicy = [RDSecurityPolicy customSecurityPolicy];
    return client;
}

- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    AFHTTPRequestOperation *operation = [super HTTPRequestOperationWithRequest:request
                                                                       success:success
                                                                       failure:failure];
    
    [operation setWillSendRequestForAuthenticationChallengeBlock:^ void(NSURLConnection *  connection, NSURLAuthenticationChallenge * challenge) {
        NSLog(@"request will send AuthenticationChallenge");
        SecIdentityRef identity;
        SecTrustRef trust = NULL;
        
        [RDSecurityPolicy extractIdentity:&identity andTrust:&trust fromPKCS12Data:[RDSecurityPolicy p12Data]];
        SecCertificateRef certificate = NULL;
        SecIdentityCopyCertificate (identity, &certificate);
        
        const void *certs[] = {certificate};
        CFArrayRef certArray = CFArrayCreate(kCFAllocatorDefault, certs, 1, NULL);
        
        NSURLCredential *credential = [NSURLCredential credentialWithIdentity:identity certificates:(__bridge NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
        [challenge.sender useCredential:credential forAuthenticationChallenge:challenge];
        CFRelease(certArray);
    }];
    return operation;
}

@end

@implementation RDSecurityPolicy
@synthesize SSLPinningMode = _SSLPinningMode;
+ (instancetype)customSecurityPolicy {
    
    RDSecurityPolicy *security = [self defaultPolicy];
    /**
     *  验证证书是否合法
     *  SecIdentityRef identity = NULL;
     *  SecTrustRef trust = NULL;
     *  BOOL valid = [self extractIdentity:&identity andTrust:&trust fromPKCS12Data:[self p12Data]];
     *  NSLog(@"%@",valid ? @"证书合法":@"验证失败");
     */
    
    [security setAllowInvalidCertificates:YES];
    [security setPinnedCertificates:@[[self cerData]]];
    security.SSLPinningMode = AFSSLPinningModeCertificate;
    return security;
}

+ (NSData *)p12Data {
    NSString *p12filePath = [[NSBundle mainBundle]pathForResource:p12Name ofType:@"p12"];
    NSAssert(p12filePath, @"cer file is not in bundle please check if fileName and file is exist");
    return [NSData dataWithContentsOfFile:p12filePath];
}


+ (NSData *)cerData {
    NSString *path = [[NSBundle mainBundle]pathForResource:@"client" ofType:@"cer"];
    return [NSData dataWithContentsOfFile:path];
}
/**
 *  检查证书是否合法
 *
 *  @param outIdentity
 *  @param outTrust
 *  @param inPKCS12Data
 *
 *  @return
 */

+ (BOOL)extractIdentity:(SecIdentityRef *)outIdentity andTrust:(SecTrustRef*)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    
    // 证书密钥
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:p12Key
                                                                  forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if (securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex (items, 0);
        const void *tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void *tempTrust = NULL;
        tempTrust = CFDictionaryGetValue (myIdentityAndTrust, kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    } else {
        NSLog(@"Failed with error code %d",(int)securityError);
        return NO;
    }
    return YES;
}
@end