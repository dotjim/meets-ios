//
//  MGShoppingCartInfo.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 11/12/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGShoppingCartInfo.h"

@implementation MGShoppingCartInfo

- (id)init
{
    self = [super init];
    if (self)
    {
        self.methodName = @"shoppingCartInfo";
    }
    return self;
}


- (id)parseResponseFromXmlString:(NSString *)xml
{
    NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"urn:Magento\"" withString:@""];
    NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
    XPathQuery *xpathQuery = [[XPathQuery alloc] init];
    NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
    NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
    shoppingCartInfoEntity *result = nil;
    if([arrayOfWSData count] > 0)
    {
        NSArray* array101 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        result = [[shoppingCartInfoEntity alloc]initWithArray:array101];
    }
    return result;
}


- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    shoppingCartInfoEntity *infoEntity = responseObject;
    MGMeetsCart *cartModel = [[MGMeetsCart alloc] initWithId:@(infoEntity.quote_id)];
    cartModel.subtotal = @(infoEntity.subtotal);
    
    for (shoppingCartItemEntity *itemEntity in infoEntity.items)
    {
        MGMeetsCartItem *cartItem = [MGMeetsCartItem new];
        cartItem.productId = @(itemEntity.product_id.integerValue);
        cartItem.quantity = @(itemEntity.qty);
        cartItem.relatedProduct = nil;
        cartItem.price = @(itemEntity.price);
        [cartModel.items addObject:cartItem];
    }
    
    return cartModel;
}

@end
