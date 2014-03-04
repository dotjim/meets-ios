//
//  MGShoppingCartAdd.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 13/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGShoppingCartProductAdd.h"

@interface MGShoppingCartProductAdd()

@property (nonatomic, strong) NSNumber *cartId;

@end

@implementation MGShoppingCartProductAdd

- (instancetype)initWithCartId:(NSNumber *)cartId
{
    self = [super init];
    if (self)
    {
        self.methodName = @"shoppingCartProductAdd";
        self.cartId = cartId;
    }
    return self;
}


- (NSString *)serializeModels:(NSArray *)arrayOfModels
{
    NSMutableString *xml = [NSMutableString string];
    [xml appendFormat:@"<quoteId>%@</quoteId><products>", self.cartId];

    for (MGMeetsCartItem *cartItem in arrayOfModels)
    {
        shoppingCartProductEntity *itemEntity = [shoppingCartProductEntity new];
        itemEntity.product_id = cartItem.productId.stringValue;
        itemEntity.sku = cartItem.productSku;
        itemEntity.qty = cartItem.quantity.doubleValue;
        itemEntity.qtySpecified = YES;
        [xml appendString:[itemEntity toString:YES]];
    }
    
    [xml appendString:@"</products>"];
    return xml;
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
        result = [NSNumber numberWithBool:[nodeContentValue boolValue]];
    }
    return result;
}

@end
