//
//  MGCustomerAddressDelete.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 10/02/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import "MGCustomerAddressDelete.h"

@implementation MGCustomerAddressDelete

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.methodName = @"customerAddressDelete";
    }
    return self;
}


- (NSString *)serializeModels:(NSArray *)arrayOfModels
{
    return [NSString stringWithFormat:@"<addressId>%@</addressId>", arrayOfModels[0]];
}


- (id)parseResponseFromXmlString:(NSString *)xml
{
    NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"urn:Magento\"" withString:@""];
    NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
    XPathQuery *xpathQuery = [[XPathQuery alloc] init];
    NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
    NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
    NSNumber *result = nil;
    if([arrayOfWSData count] > 0)
    {
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        result = [NSNumber numberWithBool:[nodeContentValue boolValue]];
    }

    return result;
}

@end
