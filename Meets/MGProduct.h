//
//  MGProducts.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 16/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "RestApiMethod.h"

@interface MGProduct : RestApiMethod

- (id)mapResponseToModelObjectWithResponse:(id)responseObject;

@end
