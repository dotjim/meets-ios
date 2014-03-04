//
//  MGCustomerAddressCreate.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 10/02/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import "SoapApiMethod.h"

@interface MGCustomerAddressCreate : SoapApiMethod

- (instancetype)initWithCustomerId:(NSNumber *)customerId;

@end
