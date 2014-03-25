//
//  MeetsRestSessionManager.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 24/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsRestSessionManager.h"

@implementation MeetsRestSessionManager

static  MeetsRestSessionManager *shared = nil;

+ (MeetsRestSessionManager *)sharedManager
{
    return shared;
}

+ (MeetsRestSessionManager *)initWithBaseUrl:(NSString *)baseUrl
                                     storeId:(NSString *)storeId
                                   websiteId:(NSString *)websiteId
                               basicAuthUser:(NSString *)serverUser
                           basicAuthPassword:(NSString *)serverPassword
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        NSURLSessionConfiguration *sessionConfiguration = [NSURLSessionConfiguration defaultSessionConfiguration];
        
//        NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:10 * 1024 * 1024
//                                                          diskCapacity:50 * 1024 * 1024
//                                                              diskPath:nil];
//        [sessionConfiguration setURLCache:cache];
//        sessionConfiguration.requestCachePolicy = NSURLRequestReloadRevalidatingCacheData;

        
        shared = [[MeetsRestSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl] sessionConfiguration:sessionConfiguration];
        shared.storeId = storeId;
        shared.websiteId = websiteId;
        shared.basicAuthUser = serverUser;
        shared.basicAuthPassword = serverPassword;
        [shared.operationQueue setMaxConcurrentOperationCount:5]; // Test this
        [shared setRequestSerializer:[AFHTTPRequestSerializer serializer]];
        
        /**** SSL Pinning Example ****/
//        NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"yourSSLCert" ofType:@"der"];
//        NSData *certData = [NSData dataWithContentsOfFile:cerPath];
//        
//        NSString *rootPath = [[NSBundle mainBundle] pathForResource:@"gd-class2-root" ofType:@"cer"];
//        NSData *rootData = [NSData dataWithContentsOfFile:rootPath];
//        
//        NSString *interPath = [[NSBundle mainBundle] pathForResource:@"gd_intermediate.crt" ofType:@"der"];
//        NSData *interData = [NSData dataWithContentsOfFile:interPath];
//
//        AFSecurityPolicy *securityPolicy = [[AFSecurityPolicy alloc] init];
//        [securityPolicy setAllowInvalidCertificates:NO];
//        [securityPolicy setPinnedCertificates:@[certData, rootData, interData]];
//        [securityPolicy setSSLPinningMode:AFSSLPinningModeCertificate];
//        shared.securityPolicy = securityPolicy;
        /**** SSL Pinning ****/

        if (serverUser && serverPassword) {
            [shared.requestSerializer setAuthorizationHeaderFieldWithUsername:shared.basicAuthUser password:shared.basicAuthPassword];
        }
    });
    
    return shared;
}

@end
