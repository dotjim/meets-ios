//
//  MGCustomerAddressList.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 21/12/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGCustomerAddressList.h"

@implementation MGCustomerAddressList

- (id)init
{
    self = [super init];
    if (self)
    {
        self.methodName = @"customerAddressList";
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
    NSMutableArray *result = nil;
    if([arrayOfWSData count] > 0)
    {
        result = [[NSMutableArray alloc] init];
        NSArray* array35 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        NSUInteger arraySize = [array35 count];
        for (int j=0;j<arraySize;j++)
        {
            NSArray* array36 = [[array35 objectAtIndex:j] objectForKey:@"nodeChildArray"];
            customerAddressEntityItem *itemResult = [[customerAddressEntityItem alloc]initWithArray:array36];
            [result addObject:itemResult];
        }
    }
    
    return result;
}


- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    if ([responseObject count] == 0) return nil;
    
    NSMutableArray *items = [NSMutableArray array];
    for (customerAddressEntityItem *addressItem in responseObject)
    {
        MeetsAddress *addressModel = [[MeetsFactory shared] makeAddress];
        
        addressModel.objectId = @(addressItem.customer_address_id);
        addressModel.firstName = addressItem.firstname;
        addressModel.lastName = addressItem.lastname;
        addressModel.street = addressItem.street;
        addressModel.city = addressItem.city;
        addressModel.region = addressItem.region;
        addressModel.regionId = [NSString stringWithFormat:@"%i", addressItem.region_id];
        addressModel.postCode = addressItem.postcode;
        addressModel.countryId = addressItem.country_id;
        addressModel.telephone = addressItem.telephone;
        addressModel.isDefaultBilling = @(addressItem.is_default_billing);
        addressModel.isDefaultShipping = @(addressItem.is_default_shipping);
        addressModel.company = addressItem.company;
        addressModel.fax = addressItem.fax;
        
        if (addressItem.is_default_billing) {
            [(MGMeetsAddress *)addressModel setMode:kAddressModeTypeBilling];
        }
        else {
            [(MGMeetsAddress *)addressModel setMode:kAddressModeTypeShipping];
        }
        
        [items addObject:addressModel];
    }
    return items;
}

@end
