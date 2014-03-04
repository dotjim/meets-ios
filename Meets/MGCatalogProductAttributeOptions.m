//
//  MGCatalogProductAttributeOptions.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 27/12/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGCatalogProductAttributeOptions.h"

@implementation MGCatalogProductAttributeOptions

- (id)init
{
    self = [super init];
    if (self) {
        self.methodName = @"catalogProductAttributeOptions";
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
        NSArray* array56 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        NSUInteger arraySize = [array56 count];
        for (int j=0;j<arraySize;j++)
        {
            NSArray* array57 = [[array56 objectAtIndex:j] objectForKey:@"nodeChildArray"];
            catalogAttributeOptionEntity *itemResult = [[catalogAttributeOptionEntity alloc]initWithArray:array57];
            [result addObject:itemResult];
        }
    }
    return result;
}

@end
