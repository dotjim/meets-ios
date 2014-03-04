//
//  MGShoppingCartProductRemove.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 02/12/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "SoapApiMethod.h"

@interface MGShoppingCartProductRemove : SoapApiMethod

- (instancetype)initWithCartId:(NSNumber *)cartId;

@end
