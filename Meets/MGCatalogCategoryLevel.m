//
//  MGCatalogCategoryTree.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 05/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGCatalogCategoryLevel.h"
#import "catalogCategoryEntityNoChildren.h"

@implementation MGCatalogCategoryLevel

- (instancetype)init
{
    self = [super init];
    if (self){
        self.methodName = @"catalogCategoryLevel";
    }
    return self;
}


- (id)parseResponseFromXmlString:(NSString *)xml
{
    NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"urn:Magento\"" withString:@""];
    NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
    XPathQuery *xpathQuery = [[XPathQuery alloc] init];
    NSString *query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
    NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
    if([arrayOfWSData count] > 0 )
    {
        NSMutableArray* result = [[NSMutableArray alloc]init];
        NSArray* array39 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        NSUInteger arraySize = [array39 count];
        for (int j=0;j<arraySize;j++)
        {
            NSArray *array40 = [[array39 objectAtIndex:j] objectForKey:@"nodeChildArray"];
            catalogCategoryEntityNoChildren* itemResult = [[catalogCategoryEntityNoChildren alloc]initWithArray:array40];
            [result addObject:itemResult];
        }
        return result;
    }
    return nil;
}

@end
