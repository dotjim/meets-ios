//
//  MGShoppingCartShippingList.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 27/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGShoppingCartShippingList.h"

@implementation MGShoppingCartShippingList

- (id)init
{
    self = [super init];
    if (self)
    {
        self.methodName = @"shoppingCartShippingList";
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
    NSMutableArray *result = nil;
    if([arrayOfWSData count] > 0)
    {
        result = [[NSMutableArray alloc] init];
        NSArray* array2 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        NSUInteger arraySize = [array2 count];
        for (int j=0;j<arraySize;j++)
        {
            NSArray* array3 = [[array2 objectAtIndex:j] objectForKey:@"nodeChildArray"];
            shoppingCartShippingMethodEntity *itemResult = [[shoppingCartShippingMethodEntity alloc]initWithArray:array3];
            [result addObject:itemResult];
        }
    }
    return result;
}


- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    if (![responseObject isKindOfClass:[NSArray class]])
    {
        if ([responseObject isKindOfClass:[NSNull class]])
        {
            return nil;
        }
        responseObject = [NSArray arrayWithObject:responseObject];
    }
    
    NSMutableArray *shippingArray = [NSMutableArray array];
    for (shoppingCartShippingMethodEntity *anObject in responseObject)
    {
        if ([anObject class] == [NSNull class]) continue;
        
        MGMeetsCartShipping *shippingModel = [MGMeetsCartShipping new];
        shippingModel.code = anObject.code;
        shippingModel.carrierCode = anObject.carrier;
        shippingModel.carrierTitle = anObject.carrier_title;
        shippingModel.title = anObject.method_title;
        shippingModel.description = anObject.method_description;
        shippingModel.price = @(anObject.price);
        
        [shippingArray addObject:shippingModel];
    }
    return shippingArray;
}

@end
