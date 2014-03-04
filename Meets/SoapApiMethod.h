//
//  SoapApiMethod.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 25/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "ApiMethod.h"


@interface SoapApiMethod : ApiMethod

- (void)runWithParams:(NSDictionary *)paramsDictionary
              filters:(filters *)filters
           completion:(RequestCompletion)completion;

- (void)runWithModels:(NSArray *)arrayOfModels
           completion:(RequestCompletion)completion;

- (NSString *)serializeModels:(NSArray *)arrayOfModels;

- (id)parseResponseFromXmlString:(NSString *)xml;

@end
