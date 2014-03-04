//
//  MGShoppingCartCustomerAddresses.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 26/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGShoppingCartCustomerAddresses.h"

@interface MGShoppingCartCustomerAddresses()

@property (nonatomic, strong) NSNumber *cartId;

@end

@implementation MGShoppingCartCustomerAddresses

- (instancetype)initWithCartId:(NSNumber *)cartId
{
    self = [super init];
    if (self)
    {
        self.methodName = @"shoppingCartCustomerAddresses";
        self.cartId = cartId;
    }
    return self;
}


- (NSString *)serializeModels:(NSArray *)arrayOfModels
{
    NSMutableString *xml = [NSMutableString string];
    [xml appendFormat:@"<quoteId>%@</quoteId><customer>", self.cartId];
    
    for (MGMeetsAddress *addressModel in arrayOfModels)
    {
        shoppingCartCustomerAddressEntity *addressEntity = [shoppingCartCustomerAddressEntity new];
        addressEntity.mode = addressModel.mode;
        addressEntity.address_id = addressModel.objectId.stringValue;
        addressEntity.firstname = addressModel.firstName;
        addressEntity.lastname = addressModel.lastName;
        addressEntity.city = addressModel.city;
        addressEntity.street = addressModel.street;
        addressEntity.region = addressModel.region;
        addressEntity.region_id = addressModel.regionId;
        addressEntity.postcode = addressModel.postCode;
        addressEntity.country_id = addressModel.countryId;
        addressEntity.telephone = addressModel.telephone;
        [xml appendString:[addressEntity toString:YES]];
    }
    
    [xml appendString:@"</customer>"];
    return xml;
}


- (id)parseResponseFromXmlString:(NSString *)xml
{
    NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"urn:Magento\"" withString:@""];
    NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
    XPathQuery *xpathQuery = [[XPathQuery alloc] init];
    NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
    NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
    NSNumber* result = nil;
    if([arrayOfWSData count] > 0)
    {
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        result = [NSNumber numberWithBool:[nodeContentValue boolValue]];
    }
    return result;
}

@end
