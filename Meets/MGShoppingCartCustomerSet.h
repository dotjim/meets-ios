//
//  MGShoppingCartCustomerSet.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 14/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "SoapApiMethod.h"

@interface MGShoppingCartCustomerSet : SoapApiMethod

- (instancetype)initWithCartId:(NSNumber *)cartId;

@end
