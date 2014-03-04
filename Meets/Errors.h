//
//  Errors.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 28/02/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import <Foundation/Foundation.h>

@interface Errors : NSObject

+ (NSException *)overrideException:(NSString *)methodName;

+ (NSException *)unsupportedOperationException:(NSString *)operation;

@end
