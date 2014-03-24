//
//  MGCatalogProductInfo.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 26/12/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGCatalogProductInfo.h"

@implementation MGCatalogProductInfo


- (id)init
{
    self = [super init];
    if (self)
    {
        self.methodName = @"catalogProductInfo";
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
    catalogProductReturnEntity *result = nil;
    if([arrayOfWSData count] > 0)
    {
        NSArray* array50 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        result = [[catalogProductReturnEntity alloc] initWithArray:array50];
    }
    
    return result;
}


- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    MeetsProduct *productModel = nil;
    
    if (responseObject)
    {
        catalogProductReturnEntity *productEntity = responseObject;
        
        productModel = [[MeetsFactory shared] makeProductWithId:@(productEntity.product_id.integerValue)];
        productModel.type = productEntity.type_id;
        productModel.sku = productEntity.sku;
        productModel.name = productEntity.name;
        productModel.description = productEntity.short_description;
        productModel.price = [NSNumber numberWithFloat:[productEntity.price floatValue]];
        
        NSMutableDictionary *additionalAttributes = [NSMutableDictionary dictionary];
        for (associativeEntity *attribute in productEntity.additional_attributes)
        {
            if (attribute.value)
                [additionalAttributes addEntriesFromDictionary:@{attribute.key: attribute.value}];
        }
        
        productModel.additionalAttributes = additionalAttributes;
    }

    return productModel;
}


@end
