//
//  MGCustomerCustomerInfo.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 25/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGCustomerCustomerInfo.h"

@implementation MGCustomerCustomerInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.methodName = @"customerCustomerInfo";
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
    customerCustomerEntity *result = nil;
    if ([arrayOfWSData count] > 0) {
        NSArray* array32 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        result = [[customerCustomerEntity alloc]initWithArray:array32];
    }

    return result;
}


- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    if (!responseObject) return nil;
    
    customerCustomerEntity *customerEntity = responseObject;
    MeetsCustomer *customer = [[MeetsFactory shared] makeCustomerWithId:@(customerEntity.customer_id)];
    customer.email = customerEntity.email;
    customer.firstName = customerEntity.firstname;
    customer.lastName = customerEntity.lastname;
    customer.passwordHash = customerEntity.password_hash;
    customer.vatNumber = customerEntity.taxvat;
    
    return customer;
}

@end
