//
//  MGMeetsCartItem.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 13/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGMeetsCartItem.h"

@implementation MGMeetsCartItem

- (instancetype)initWithProduct:(MGMeetsProduct *)aProduct
{
    self = [super init];
    if (self)
    {
        self.productId = aProduct.objectId;
        self.productSku = aProduct.sku;
        self.name = aProduct.name;
        self.description = aProduct.description;
        self.quantity = @(1);
        self.relatedProduct = aProduct;
        self.price = aProduct.price;
    }
    return self;
}

@end
