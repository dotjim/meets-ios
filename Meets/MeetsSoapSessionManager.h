//
//  MeetsSoapSessionManager.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 26/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "AFHTTPRequestOperationManager.h"

@interface MeetsSoapSessionManager : AFHTTPRequestOperationManager

@property (nonatomic, strong) NSString *apiSessionID;
@property (nonatomic, strong) NSString *storeId, *websiteId;
@property (nonatomic, strong) NSString *soapApiUser, *soapApiPassword;
@property (nonatomic, strong) NSString *basicAuthUser, *basicAuthPassword;

+ (MeetsSoapSessionManager *)initWithBaseUrl:(NSString *)baseUrl
                                     storeId:(NSString *)storeId
                                   websiteId:(NSString *)websiteId
                                 soapApiUser:(NSString *)apiUser
                             soapApiPassword:(NSString *)apiPassword
                               basicAuthUser:(NSString *)serverUser
                           basicAuthPassword:(NSString *)serverPassword;

+ (MeetsSoapSessionManager *)sharedManager;

@end