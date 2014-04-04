//
//  MGShoppingCartPaymentMethod.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 28/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGShoppingCartPaymentMethod.h"

@interface MGShoppingCartPaymentMethod ()

@property (nonatomic, strong) NSNumber *cartId;

@end

@implementation MGShoppingCartPaymentMethod

- (instancetype)initWithCartId:(NSNumber *)cartId
{
    self = [super init];
    if (self)
    {
        self.methodName = @"shoppingCartPaymentMethod";
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
    if([arrayOfWSData count] > 0 )
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
    
#warning Only supports token based payment methods (i.e: Stripe)
    for (MGMeetsCartPayment *paymentModel in arrayOfModels)
    {
        if (paymentModel.token)
        {
            [xml appendFormat:@"<method>%@</method><payment_token>%@</payment_token>", paymentModel.code, paymentModel.token];
        }
        break;
    }
    
    [xml appendString:@"</method>"];
    return xml;
}

@end
