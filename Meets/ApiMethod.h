//
//  ApiMethod.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 14/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import <Foundation/Foundation.h>

@interface ApiMethod : NSObject

@property (nonatomic, strong) NSString *methodName;

- (id)mapResponseToModelObjectWithResponse:(id)responseObject;

- (id)getModelFromResponse:(id)responseObject;

- (NSError *)getErrorFromResponse:(id)responseObject;

@end
