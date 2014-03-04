//
//  Errors.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 28/02/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import "Errors.h"

@implementation Errors

+ (NSException *)overrideException:(NSString *)methodName
{
    return [NSException exceptionWithName:NSInternalInconsistencyException
                            reason:[NSString stringWithFormat:@"You must override %@ in a subclass", methodName]
                          userInfo:nil];
}


+ (NSException *)unsupportedOperationException:(NSString *)operation
{
    return [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:[NSString stringWithFormat:@"Unsupported operation %@. Not yet implemented in 0.0.1", operation]
                                 userInfo:nil];
}

@end
