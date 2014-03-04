//
//  MGShoppingCartPaymentMethod.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 28/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "SoapApiMethod.h"

@interface MGShoppingCartPaymentMethod : SoapApiMethod

- (instancetype)initWithCartId:(NSNumber *)cartId;

@end
