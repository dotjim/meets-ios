//
//  MGShoppingCartCreate.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 13/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGShoppingCartCreate.h"

@implementation MGShoppingCartCreate

- (id)init
{
    self = [super init];
    if (self)
    {
        self.methodName = @"shoppingCartCreate";
    }
    return self;
}


- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    MeetsCart *cart = [[MeetsFactory shared] makeCart];
    cart.objectId = @([responseObject integerValue]);
    return cart;
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
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        return [NSNumber numberWithInt:[nodeContentValue intValue]];
    }
    return nil;
}

@end
