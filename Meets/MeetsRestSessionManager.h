//
//  MeetsRestSessionManager.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 24/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "AFHTTPSessionManager.h"

@interface MeetsRestSessionManager : AFHTTPSessionManager

@property (nonatomic, strong) NSString *storeId, *websiteId;
@property (nonatomic, strong) NSString *basicAuthUser, *basicAuthPassword;

+ (MeetsRestSessionManager *)sharedManager;

+ (MeetsRestSessionManager *)initWithBaseUrl:(NSString *)baseUrl
                                     storeId:(NSString *)storeId
                                   websiteId:(NSString *)websiteId
                               basicAuthUser:(NSString *)serverUser
                           basicAuthPassword:(NSString *)serverPassword;

@end
