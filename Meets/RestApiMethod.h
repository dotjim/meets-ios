//
//  RestApiMethod.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 14/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "ApiMethod.h"

@interface RestApiMethod : ApiMethod

- (void)runWithParams:(NSArray *)paramsArray
              filters:(NSDictionary *)filters
           completion:(RequestCompletion)completion;

- (NSDictionary *)serializeModels:(NSArray *)arrayOfModels;

@end
