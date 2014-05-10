//
//  MGProducts.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 16/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGProducts.h"

@implementation MGProducts

- (id)getModelFromResponse:(id)responseObject
{
    if ([responseObject isKindOfClass:[NSDictionary class]])
    {
        MeetsCollection *productCollection = [[MeetsFactory shared] makeProductCollection];
        for (NSString *aKey in [responseObject allKeys])
        {
            [productCollection.collection addObject:[self mapResponseToModelObjectWithResponse:responseObject[aKey]]];
        }
        return productCollection;
    }
    
    return [self mapResponseToModelObjectWithResponse:responseObject];
}


@end
