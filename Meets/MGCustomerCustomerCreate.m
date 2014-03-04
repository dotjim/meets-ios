//
//  MGCustomerCustomerCreate.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 23/01/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import "MGCustomerCustomerCreate.h"

@implementation MGCustomerCustomerCreate

- (id)init
{
    self = [super init];
    if (self)
    {
        self.methodName = @"customerCustomerCreate";
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
    NSNumber *result = nil;
    if([arrayOfWSData count] > 0)
    {
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        result = [NSNumber numberWithInt:[nodeContentValue intValue]];
    }
    return result;
}


- (NSString *)serializeModels:(NSArray *)arrayOfModels
{
    NSMutableString *xml = [NSMutableString string];
    [xml appendFormat:@"<customerData>"];

    for (MeetsCustomer *theCustomer in arrayOfModels)
    {
        customerCustomerEntityToCreate *soapEntity = [customerCustomerEntityToCreate new];
        soapEntity.email = theCustomer.email;
        soapEntity.firstname = theCustomer.firstName;
        soapEntity.lastname = theCustomer.lastName;
        soapEntity.password = theCustomer.password;
        soapEntity.taxvat = theCustomer.vatNumber;
        soapEntity.store_id = [MeetsRestSessionManager sharedManager].storeId.integerValue;
        soapEntity.store_idSpecified = YES;
        soapEntity.website_id = [MeetsRestSessionManager sharedManager].websiteId.integerValue;
        soapEntity.website_idSpecified = YES;
        [xml appendString:[soapEntity toString:NO]];
        break; // Will only pick one.
    }
    
    [xml appendFormat:@"</customerData>"];
    return xml;
}

@end
