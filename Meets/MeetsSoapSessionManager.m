//
//  MeetsSoapSessionManager.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 26/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsSoapSessionManager.h"
#import "AFXMLDictionaryResponseSerializer.h"

@implementation MeetsSoapSessionManager

static MeetsSoapSessionManager *shared = nil;

+ (MeetsSoapSessionManager *)sharedManager
{
    return shared;
}


+ (MeetsSoapSessionManager *)initWithBaseUrl:(NSString *)baseUrl
                                     storeId:(NSString *)storeId
                                   websiteId:(NSString *)websiteId
                                 soapApiUser:(NSString *)apiUser
                             soapApiPassword:(NSString *)apiPassword
                               basicAuthUser:(NSString *)serverUser
                           basicAuthPassword:(NSString *)serverPassword
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [[AFNetworkActivityIndicatorManager sharedManager] setEnabled:YES];
        
        shared = [[MeetsSoapSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        shared.storeId = storeId;
        shared.websiteId = websiteId;
        shared.soapApiUser = apiUser;
        shared.soapApiPassword = apiPassword;
        shared.basicAuthUser = serverUser;
        shared.basicAuthPassword = serverPassword;
        shared.responseSerializer = [AFXMLDictionaryResponseSerializer serializer];
        [shared.operationQueue setMaxConcurrentOperationCount:5];

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
    });
    return shared;
}



@end
