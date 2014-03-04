//
//  MGCatalogInventoryStockItemList.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 31/12/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGCatalogInventoryStockItemList.h"

@implementation MGCatalogInventoryStockItemList

- (id)init
{
    self = [super init];
    if (self) {
        self.methodName = @"catalogInventoryStockItemList";
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
        NSArray* array99 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        NSUInteger arraySize = [array99 count];
        for (int j=0;j<arraySize;j++)
        {
            NSArray* array100 = [[array99 objectAtIndex:j] objectForKey:@"nodeChildArray"];
            catalogInventoryStockItemEntity *itemResult = [[catalogInventoryStockItemEntity alloc]initWithArray:array100];
            [result addObject:itemResult];
        }
    }
    
    return result;
}

- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    MGMeetsStockItemList *stockItemList = [MGMeetsStockItemList new];
    
    NSMutableArray *itemsArray = [NSMutableArray array];
    for (catalogInventoryStockItemEntity *item in responseObject)
    {
        MGMeetsStockItem *anItem = [MGMeetsStockItem new];
        anItem.sku = item.sku;
        anItem.productId = @([item.product_id integerValue]);
        anItem.quantity = @([item.qty doubleValue]);
        anItem.isInStock = @([item.is_in_stock boolValue]);
        
        [itemsArray addObject:anItem];
    }
    
    stockItemList.productsInStock = itemsArray;
    
    return stockItemList;
}

@end
