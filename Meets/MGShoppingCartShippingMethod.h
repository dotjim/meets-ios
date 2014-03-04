//
//  MGShoppingCartShippingMethod.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 27/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "SoapApiMethod.h"

@interface MGShoppingCartShippingMethod : SoapApiMethod

- (instancetype)initWithCartId:(NSNumber *)cartId;

@end
