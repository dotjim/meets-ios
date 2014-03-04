//
//  MeetsCart.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 13/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsCart.h"

@implementation MeetsCart

- (NSNumber *)itemsTotalQuantity
{
    double output = 0;
    for (MeetsCartItem *cartItem in self.items)
        output += cartItem.quantity.doubleValue;
    
    return @(output);
}


- (void)createWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)addItemFromProduct:(MeetsProduct *)aProduct
                  quantity:(NSNumber *)quantity
                completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)addItemsFromProducts:(NSArray *)products
                  quantities:(NSArray *)quantities
                  completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)addItem:(MeetsCartItem *)cartItem
     completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)addItems:(NSArray *)itemsArray
      completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)removeItemWithProductId:(NSNumber *)productId
                       quantity:(NSNumber *)quantity
                     completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)removeItemWithProductId:(NSNumber *)productId
                     completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)removeItemsWithProductIds:(NSArray *)productIds
                       quantities:(NSArray *)quantities
                       completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)removeItemsWithProductIds:(NSArray *)productIds
                       completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)attachCustomer:(MeetsCustomer *)customer
            completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)attachCustomerAsGuest:(MeetsCustomer *)customer
                   completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)attachBillingAddress:(MeetsAddress *)billingAddress
             shippingAddress:(MeetsAddress *)shippingAddress
                  completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)attachShippingMethod:(MeetsCartShipping *)shippingMethod completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)attachPaymentMethod:(MeetsCartPayment *)paymentMethod completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)fetchShippingMethodsWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)fetchPaymentMethodsWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)orderWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

@end
