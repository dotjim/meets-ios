//
//  Meets.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 16/12/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "Meets.h"

@implementation Meets

static const NSString *kRestUrlSuffix = @"/api/rest/";
static const NSString *kSoapBaseUrlSuffix = @"/api/v2_soap/";

+ (void)initWithFactory:(MeetsFactory *)factory
                hostUrl:(NSString *)url
            soapApiUser:(NSString *)apiUser
        soapApiPassword:(NSString *)apiPassword
{
    [Meets initWithFactory:factory hostUrl:url soapApiUser:apiUser soapApiPassword:apiPassword storeId:nil websiteId:nil basicAuthUser:nil basicAuthPassword:nil restBaseUrl:[Meets restBaseUrlWithHostUrl:url]];
}


+ (void)initWithFactory:(MeetsFactory *)factory
                hostUrl:(NSString *)url
            soapApiUser:(NSString *)apiUser
        soapApiPassword:(NSString *)apiPassword
                storeId:(NSString *)storeId
              websiteId:(NSString *)websiteId
{
    [Meets initWithFactory:factory hostUrl:url soapApiUser:apiUser soapApiPassword:apiPassword storeId:storeId websiteId:websiteId basicAuthUser:nil basicAuthPassword:nil restBaseUrl:[Meets restBaseUrlWithHostUrl:url]];
}

+ (void)initWithFactory:(MeetsFactory *)factory
                hostUrl:(NSString *)url
            soapApiUser:(NSString *)apiUser
        soapApiPassword:(NSString *)apiPassword
                storeId:(NSString *)storeId
              websiteId:(NSString *)websiteId
          basicAuthUser:(NSString *)serverUser
      basicAuthPassword:(NSString *)serverPassword
{
    [Meets initWithFactory:factory hostUrl:url soapApiUser:apiUser soapApiPassword:apiPassword storeId:storeId websiteId:websiteId basicAuthUser:serverUser basicAuthPassword:serverPassword restBaseUrl:[Meets restBaseUrlWithHostUrl:url]];
}

+ (void)initWithFactory:(MeetsFactory *)factory
                hostUrl:(NSString *)url
            soapApiUser:(NSString *)apiUser
        soapApiPassword:(NSString *)apiPassword
                storeId:(NSString *)storeId
              websiteId:(NSString *)websiteId
          basicAuthUser:(NSString *)serverUser
      basicAuthPassword:(NSString *)serverPassword
            restBaseUrl:(NSString *)restBaseUrl
{
    [MeetsFactory initWithFactory:factory];
    
    [MeetsRestSessionManager initWithBaseUrl:restBaseUrl storeId:storeId websiteId:websiteId basicAuthUser:serverUser basicAuthPassword:serverPassword];
    
    [MeetsSoapSessionManager initWithBaseUrl:[Meets soapBaseUrlWithHostUrl:url] storeId:storeId websiteId:websiteId soapApiUser:apiUser soapApiPassword:apiPassword basicAuthUser:serverUser basicAuthPassword:serverPassword];
}


#pragma mark - URL utils

+ (NSString *)restBaseUrlWithHostUrl:(NSString *)hostUrl
{
    return [NSString stringWithFormat:@"%@%@", hostUrl, kRestUrlSuffix];
}


+ (NSString *)soapBaseUrlWithHostUrl:(NSString *)hostUrl
{
    return [NSString stringWithFormat:@"%@%@", hostUrl, kSoapBaseUrlSuffix];
}


@end
