//
//  MGShoppingCartCustomerSet.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 14/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGShoppingCartCustomerSet.h"

@interface MGShoppingCartCustomerSet ()

@property (nonatomic, strong) NSNumber *cartId;

@end

@implementation MGShoppingCartCustomerSet

- (instancetype)initWithCartId:(NSNumber *)cartId
{
    self = [super init];
    if (self)
    {
        self.methodName = @"shoppingCartCustomerSet";
        self.cartId = cartId;
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
        result = [NSNumber numberWithBool:[nodeContentValue boolValue]];
    }
    return result;
}


- (NSString *)serializeModels:(NSArray *)arrayOfModels
{
    NSMutableString *xml = [NSMutableString string];
    [xml appendFormat:@"<quoteId>%@</quoteId><customer>", self.cartId];
    
    for (MeetsCustomer *aCustomer in arrayOfModels)
    {
        shoppingCartCustomerEntity *customerEntity = [shoppingCartCustomerEntity new];
        customerEntity.mode = aCustomer.objectId ? MGCustomerModeCustomer : MGCustomerModeGuest;
        customerEntity.customer_id = aCustomer.objectId.integerValue;
        customerEntity.email = aCustomer.email;
        customerEntity.firstname = aCustomer.firstName;
        customerEntity.lastname = aCustomer.lastName;
        customerEntity.password = aCustomer.passwordHash;
        customerEntity.taxvat = aCustomer.vatNumber;
        [xml appendString:[customerEntity toString:NO]];
    }
    [xml appendString:@"</customer>"];
    return xml;
}

@end
