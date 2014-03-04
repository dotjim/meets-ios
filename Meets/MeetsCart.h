//
//  MeetsCart.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 13/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsModel.h"

@interface MeetsCart : MeetsModel

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *shippingMethods;
@property (nonatomic, strong) NSMutableArray *paymentMethods;
@property (nonatomic, strong) NSNumber *itemsTotalQuantity;
@property (nonatomic, strong) NSNumber *total, *subtotal; // Grand total is total
@property (nonatomic, strong) NSString *orderId;


- (void)createWithCompletion:(MeetsCompletion)completion;

- (void)addItemFromProduct:(MeetsProduct *)aProduct
                  quantity:(NSNumber *)quantity
                completion:(MeetsCompletion)completion;

- (void)addItemsFromProducts:(NSArray *)products
             quantities:(NSArray *)quantities
                  completion:(MeetsCompletion)completion;

- (void)addItem:(MeetsCartItem *)cartItem
     completion:(MeetsCompletion)completion;

- (void)addItems:(NSArray *)itemsArray
      completion:(MeetsCompletion)completion;

- (void)removeItemWithProductId:(NSNumber *)productId
                       quantity:(NSNumber *)quantity
                     completion:(MeetsCompletion)completion;

- (void)removeItemWithProductId:(NSNumber *)productId
              completion:(MeetsCompletion)completion;

- (void)removeItemsWithProductIds:(NSArray *)productIds
                       quantities:(NSArray *)quantities
                       completion:(MeetsCompletion)completion;

- (void)removeItemsWithProductIds:(NSArray *)productIds
                       completion:(MeetsCompletion)completion;


- (void)attachCustomer:(MeetsCustomer *)customer
            completion:(MeetsCompletion)completion;

- (void)attachCustomerAsGuest:(MeetsCustomer *)customer
                   completion:(MeetsCompletion)completion;


- (void)attachBillingAddress:(MeetsAddress *)billingAddress
             shippingAddress:(MeetsAddress *)shippingAddress
                  completion:(MeetsCompletion)completion;

- (void)attachShippingMethod:(MeetsCartShipping *)shippingMethod completion:(MeetsCompletion)completion;

- (void)attachPaymentMethod:(MeetsCartPayment *)paymentMethod completion:(MeetsCompletion)completion;

- (void)fetchShippingMethodsWithCompletion:(MeetsCompletion)completion;

- (void)fetchPaymentMethodsWithCompletion:(MeetsCompletion)completion;

- (void)orderWithCompletion:(MeetsCompletion)completion;

@end
