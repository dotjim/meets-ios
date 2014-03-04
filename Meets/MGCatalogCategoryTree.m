//
//  MGCatalogCategoryTree.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 11/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGCatalogCategoryTree.h"
#import "catalogCategoryTree.h"

@implementation MGCatalogCategoryTree

- (id)init
{
    self = [super init];
    if (self)
    {
        self.methodName = @"catalogCategoryTree";
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
    if([arrayOfWSData count] > 0 )
    {
        NSArray* array38 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        catalogCategoryTree* result = [[catalogCategoryTree alloc] initWithArray:array38];
        return result;
    }
    return nil;
    


}

@end
