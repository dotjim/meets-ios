//
//  MGLogin.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 26/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGLogin.h"

@implementation MGLogin

- (id)init
{
    self = [super init];
    if (self) {
        self.methodName = @"login";
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
    NSString* result = nil;
    if([arrayOfWSData count] > 0 )
    {
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
    }
    return result;
}

@end
