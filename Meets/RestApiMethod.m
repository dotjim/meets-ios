//
//  RestApiMethod.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 14/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "RestApiMethod.h"

@implementation RestApiMethod

- (NSString *)requestFinalURLWithParams:(NSArray *)paramsArray filters:(NSDictionary *)filters
{
    MeetsRestSessionManager *manager = [MeetsRestSessionManager sharedManager];
    NSString *finalURL = [manager.baseURL.absoluteString stringByAppendingPathComponent:self.methodName];
    
    for (id param in paramsArray) {
        finalURL = [finalURL stringByAppendingPathComponent:[param stringValue]];
    }
    
    finalURL = [finalURL stringByAppendingFormat:@"/store/%@", manager.storeId];
    
    NSArray *allKeys = [filters allKeys];
    int subfiltersCount = 0;
    if (allKeys.count > 0)
    {
        finalURL = [finalURL stringByAppendingString:@"?"];
        for (NSString *aKey in [filters allKeys])
        {
            id anObject = [filters objectForKey:aKey];
            if ([anObject isKindOfClass:[NSDictionary class]])
            {
                for (NSString *subfilterKey in [anObject allKeys])
                {
                    finalURL = [finalURL stringByAppendingFormat:@"&filter[%i][%@]=%@", subfiltersCount, subfilterKey, anObject[subfilterKey]];
                }
                subfiltersCount++;
            }
            else
                finalURL = [finalURL stringByAppendingFormat:@"&%@=%@", aKey, filters[aKey]];
        }
    }
    
    return finalURL;
}


- (void)runWithParams:(NSArray *)paramsArray filters:(NSDictionary *)filters completion:(RequestCompletion)completion
{
    MeetsRestSessionManager *manager = [MeetsRestSessionManager sharedManager];
    NSString *finalURL = [self requestFinalURLWithParams:paramsArray filters:filters];
    NSURL *url = [NSURL URLWithString:finalURL];
    
    // NSLog(@"FINAL URL = %@", url.absoluteURL);
    [manager GET:url.absoluteString parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        completion([self getModelFromResponse:responseObject], nil);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        completion(nil, error);
    }];
    
}


- (NSDictionary *)serializeModels:(NSArray *)arrayOfModels
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

@end
