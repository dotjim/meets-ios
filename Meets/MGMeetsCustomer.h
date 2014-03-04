//
//  MGMeetsCustomer.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 14/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsCustomer.h"

#define MGCustomerModeCustomer @"customer"
#define MGCustomerModeGuest @"guest"

@interface MGMeetsCustomer : MeetsCustomer

@property (nonatomic, strong) NSString *type;

@end
