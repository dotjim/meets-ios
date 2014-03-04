//
//  ApiMethod.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 14/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "ApiMethod.h"

@implementation ApiMethod

- (id)getModelFromResponse:(id)responseObject // Default implementation for basic types (NSNumbers...)
{
    return responseObject;
}


- (id)mapResponseToModelObjectWithResponse:(id)responseObject // Default implementation for basic types (NSNumbers...)
{
    return responseObject;
}


- (NSError *)getErrorFromResponse:(id)responseObject
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}



@end
