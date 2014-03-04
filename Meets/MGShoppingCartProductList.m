//
//  MGShoppingCartProductList.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 19/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGShoppingCartProductList.h"

@implementation MGShoppingCartProductList

- (id)init
{
    self = [super init];
    if (self)
    {
        self.methodName = @"shoppingCartProductList";
    }
    return self;
}


- (id)mapResponseToModelObjectWithResponse:(id)responseObject // responseObject = Array of catalogProductEntity
{
    if ([responseObject count] == 0) return nil;
    
    NSMutableArray *items = [NSMutableArray array];
    for (catalogProductEntity *productEntity in responseObject)
    {
        MGMeetsCartItem *item = [MGMeetsCartItem new];
        item.productId = @(productEntity.product_id.integerValue);
        item.productSku = productEntity.sku;
        [items addObject:item];
    }
    return items;
}


- (id)parseResponseFromXmlString:(NSString *)xml
{
    NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"urn:Magento\"" withString:@""];
    NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
    XPathQuery *xpathQuery = [[XPathQuery alloc] init];
    NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
    NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
    if([arrayOfWSData count] > 0)
    {
        NSMutableArray *result = [[NSMutableArray alloc]init];
        NSArray* array48 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        NSUInteger arraySize = [array48 count];
        for (int j=0;j<arraySize;j++)
        {
            NSArray* array49 = [[array48 objectAtIndex:j] objectForKey:@"nodeChildArray"];
            catalogProductEntity *itemResult = [[catalogProductEntity alloc]initWithArray:array49];
            [result addObject:itemResult];
        }
        return result;
    }
    return nil;
}

@end
