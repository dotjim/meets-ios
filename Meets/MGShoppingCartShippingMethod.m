//
//  MGShoppingCartShippingMethod.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 27/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGShoppingCartShippingMethod.h"

@interface MGShoppingCartShippingMethod ()

@property (nonatomic, strong) NSNumber *cartId;

@end

@implementation MGShoppingCartShippingMethod

- (instancetype)initWithCartId:(NSNumber *)cartId
{
    self = [super init];
    if (self)
    {
        self.methodName = @"shoppingCartShippingMethod";
        self.cartId = cartId;
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
    NSNumber *result = nil;
    if([arrayOfWSData count] > 0)
    {
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        result = [NSNumber numberWithBool:[nodeContentValue boolValue]];
    }
    return result;
}

- (NSString *)serializeModels:(NSArray *)arrayOfModels
{
    NSMutableString *xml = [NSMutableString string];
    [xml appendFormat:@"<quoteId>%@</quoteId><method>", self.cartId];
    
    for (MGMeetsCartShipping *shippingModel in arrayOfModels)
    {
        [xml appendString:shippingModel.code];
        break; // Pick only one method
    }
    
    [xml appendString:@"</method>"];
    return xml;
}

@end
