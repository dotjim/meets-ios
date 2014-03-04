//
//  MGCatalogProductList.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 23/12/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGCatalogProductList.h"

@implementation MGCatalogProductList

- (id)init
{
    self = [super init];
    if (self)
    {
        self.methodName = @"catalogProductList";
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
        result = [[NSMutableArray alloc]init];
        NSArray* array48 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        NSUInteger arraySize = [array48 count];
        for (int j=0;j<arraySize;j++)
        {
            NSArray* array49 = [[array48 objectAtIndex:j] objectForKey:@"nodeChildArray"];
            catalogProductEntity *itemResult = [[catalogProductEntity alloc]initWithArray:array49];
            [result addObject:itemResult];
        }
    }

    return result;
}


- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    if ([responseObject count] == 0) return nil;
    
    NSMutableArray *items = [NSMutableArray array];
    for (catalogProductEntity *productEntity in responseObject)
    {
        MeetsProduct *productModel = [[MeetsFactory shared] makeProductWithId:@(productEntity.product_id.integerValue)];
        productModel.sku = productEntity.sku;
        productModel.name = productEntity.name;
        
        [items addObject:productModel];
    }
    return items;
}


@end
