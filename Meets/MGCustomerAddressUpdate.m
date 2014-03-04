//
//  MGCustomerAddressUpdate.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 10/02/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import "MGCustomerAddressUpdate.h"

@implementation MGCustomerAddressUpdate

- (id)init
{
    self = [super init];
    if (self)
    {
        self.methodName = @"customerAddressUpdate";
    }
    return self;
}


- (NSString *)serializeModels:(NSArray *)arrayOfModels
{
    NSMutableString *xml = [NSMutableString string];
    
    if (arrayOfModels.count > 0)
    {
        MeetsAddress *addressModel = arrayOfModels[0];
        [xml appendFormat:@"<addressId>%@</addressId><addressData>", addressModel.objectId];
        customerAddressEntityCreate *addressEntity = [customerAddressEntityCreate new];
        addressEntity.firstname = addressModel.firstName;
        addressEntity.lastname = addressModel.lastName;
        addressEntity.telephone = addressModel.telephone;
        addressEntity.street = (NSMutableArray *)@[addressModel.street];
        addressEntity.country_id = addressModel.countryId;
        addressEntity.region = addressModel.region;
        addressEntity.region_id = addressModel.regionId.integerValue;
        addressEntity.city = addressModel.city;
        addressEntity.postcode = addressModel.postCode;
        addressEntity.is_default_billingSpecified =
        addressEntity.is_default_shippingSpecified = YES;
        addressEntity.is_default_billing = addressModel.isDefaultBilling.boolValue;
        addressEntity.is_default_shipping = addressModel.isDefaultShipping.boolValue;
        [xml appendString:[addressEntity toString:NO]];
    }
    
    [xml appendString:@"</addressData>"];
    return xml;
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
