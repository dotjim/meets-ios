//
//  MGProducts.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 16/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGProducts.h"

@implementation MGProducts

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.methodName = @"products";
    }
    return self;
}


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


- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    MeetsProduct *productModel = [[MeetsFactory shared] makeProductWithId:@([responseObject[@"entity_id"] integerValue])];
    productModel.name = responseObject[@"name"];
    productModel.description = responseObject[@"short_description"];
    productModel.imageURL = responseObject[@"image_url"];
    productModel.price = responseObject[@"final_price_with_tax"];
    productModel.sku = responseObject[@"sku"];
    productModel.type = responseObject[@"type_id"];
    
    return productModel;
}



@end
