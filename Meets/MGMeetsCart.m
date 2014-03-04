//
//  MGMeetsCart.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 13/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGMeetsCart.h"

@implementation MGMeetsCart

- (id)init
{
    self = [super init];
    if (self) {
        self.items = [NSMutableArray array];
    }
    return self;
}


- (id)initWithId:(NSNumber *)theId
{
    self = [self init];
    if (self)
        self.objectId = theId;
    
    return self;
}


- (void)fetchWithCompletion:(MeetsCompletion)completion
{
    MGShoppingCartInfo *infoMethod = [MGShoppingCartInfo new];
    [infoMethod runWithParams:@{@"quoteId": self.objectId} filters:nil completion:^(id responseObject, NSError *error) {
        if (!error)
            [self fillWithModel:responseObject];
        
        completion(error);
    }];
}

- (void)createWithCompletion:(MeetsCompletion)completion
{
    MGShoppingCartCreate *createMethod = [MGShoppingCartCreate new];
    [createMethod runWithParams:nil filters:nil completion:^(id responseObject, NSError *error) {
        if (!error)
            [self fillWithModel:responseObject];
        
        completion(error);
    }];
}

- (void)attachCustomer:(MeetsCustomer *)customer
            completion:(MeetsCompletion)completion
{
    MGShoppingCartCustomerSet *setMethod = [[MGShoppingCartCustomerSet alloc] initWithCartId:self.objectId];
    [setMethod runWithModels:@[customer] completion:^(id responseObject, NSError *error) {
        if (!error && ![responseObject boolValue]) {
            error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                        code:0
                                    userInfo:[NSDictionary dictionaryWithObject:@"Could not attach the customer to the cart" forKey:NSLocalizedDescriptionKey]];
        }

        completion(error);
    }];
}


- (void)addItem:(MeetsCartItem *)cartItem
     completion:(MeetsCompletion)completion
{
    [self addItems:@[cartItem] completion:^(NSError *error) {
        completion(error);
    }];
}


- (void)addItemFromProduct:(MeetsProduct *)aProduct
                  quantity:(NSNumber *)quantity
                completion:(MeetsCompletion)completion
{
    MeetsCartItem *item = [[MeetsFactory shared] makeCartItemWithProduct:aProduct];
    item.quantity = quantity;
    
    [self addItems:@[item] completion:^(NSError *error) {
        completion(error);
    }];
}


- (void)addItems:(NSArray *)itemsArray
      completion:(MeetsCompletion)completion
{
    MGShoppingCartProductAdd *addMethod = [[MGShoppingCartProductAdd alloc] initWithCartId:self.objectId];
    [addMethod runWithModels:itemsArray completion:^(id responseObject, NSError *error) {
        if (!error)
        {
            if([responseObject boolValue]) {
                for (MeetsCartItem *item in itemsArray) {
                    MeetsCartItem *filteredItem = [self itemWithProductId:item.productId];
                    if (filteredItem) {
                        filteredItem.quantity = @(filteredItem.quantity.doubleValue + item.quantity.doubleValue);
                    } else {
                        [self.items addObject:item];
                    }
                }
            } else {
                error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                            code:0
                                        userInfo:[NSDictionary dictionaryWithObject:@"Could not add item(s) to cart" forKey:NSLocalizedDescriptionKey]];
            }

        }
        completion(error);
    }];
}


- (void)addItemsFromProducts:(NSArray *)products
                  quantities:(NSArray *)quantities
                  completion:(MeetsCompletion)completion
{
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < products.count; i++) {
        MeetsCartItem *item = [[MeetsFactory shared] makeCartItemWithProduct:products[i]];
        item.quantity = quantities[i];
        [items addObject:item];
    }
    
    [self addItems:items completion:^(NSError *error) {
        completion(error);
    }];
}


- (void)removeItemWithProductId:(NSNumber *)productId
                     completion:(MeetsCompletion)completion
{
    MeetsCartItem *filteredItem = [self itemWithProductId:productId];
    [self removeItemsWithProductIds:@[filteredItem.productId]
                         quantities:@[filteredItem.quantity]
                         completion:^(NSError *error) {
        completion(error);
    }];
}


- (void)removeItemWithProductId:(NSNumber *)productId
                       quantity:(NSNumber *)quantity
                     completion:(MeetsCompletion)completion
{
    MeetsCartItem *filteredItem = [self itemWithProductId:productId];
    [self removeItemsWithProductIds:@[filteredItem.productId]
                         quantities:@[quantity]
                         completion:^(NSError *error) {
        completion(error);
    }];
}


- (void)removeItemsWithProductIds:(NSArray *)productIds
                       completion:(MeetsCompletion)completion
{
    NSMutableArray *quantities = [NSMutableArray array];
    for (NSNumber *productId in productIds) {
        MeetsCartItem *filteredItem = [self itemWithProductId:productId];
        if (filteredItem) {
            [quantities addObject:filteredItem.quantity];
        } else {
            [quantities addObject:@(0)];
        }
    }

    [self removeItemsWithProductIds:productIds
                         quantities:quantities
                         completion:^(NSError *error) {
        completion(error);
    }];
}


#warning not fully tested:
- (void)removeItemsWithProductIds:(NSArray *)productIds
                       quantities:(NSArray *)quantities
                       completion:(MeetsCompletion)completion
{
    NSMutableArray *itemsToRemove = [NSMutableArray array];
    NSArray *itemsCopy = [self.items copy];
    
    for (int i = 0; i < productIds.count; i++) {
        MeetsCartItem *filteredItem = [self itemWithProductId:productIds[i]];
        if (filteredItem) {
            double remainingItems = filteredItem.quantity.doubleValue - [quantities[i] doubleValue];
            if (remainingItems <= 0) {
                [itemsToRemove addObject:filteredItem];
                [self.items removeObject:filteredItem];
            } else {
                MeetsCartItem *itemCopy = [filteredItem copy];
                itemCopy.quantity = quantities[i];
                [itemsToRemove addObject:itemCopy];
                filteredItem.quantity = @(remainingItems);
            }
        }
    }
    
    MGShoppingCartProductRemove *removeMethod = [[MGShoppingCartProductRemove alloc] initWithCartId:self.objectId];

    [removeMethod runWithModels:itemsToRemove completion:^(id responseObject, NSError *error) {
        if (!error)
        {
            if (![responseObject boolValue]) {
                self.items = (NSMutableArray *)itemsCopy; // undo
                error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                            code:0
                                        userInfo:[NSDictionary dictionaryWithObject:@"Could not remove item(s) from cart" forKey:NSLocalizedDescriptionKey]];
            }
        }
        
        completion(error);
    }];
}


- (void)attachBillingAddress:(MeetsAddress *)billingAddress shippingAddress:(MeetsAddress *)shippingAddress completion:(MeetsCompletion)completion
{
    [(MGMeetsAddress *)billingAddress setMode:kAddressModeTypeBilling];
    [(MGMeetsAddress *)shippingAddress setMode:kAddressModeTypeShipping];
    
    MGShoppingCartCustomerAddresses *addressesMethod = [[MGShoppingCartCustomerAddresses alloc] initWithCartId:self.objectId];
    [addressesMethod runWithModels:@[billingAddress, shippingAddress] completion:^(id responseObject, NSError *error) {
        if (!error && ![responseObject boolValue]) {
                error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                            code:0
                                        userInfo:[NSDictionary dictionaryWithObject:@"Could not attach addresses to cart" forKey:NSLocalizedDescriptionKey]];
        }
        
        completion(error);
    }];
}


- (void)fetchShippingMethodsWithCompletion:(MeetsCompletion)completion
{
    MGShoppingCartShippingList *listMethod = [MGShoppingCartShippingList new];
    [listMethod runWithParams:@{@"quoteId": self.objectId} filters:nil completion:^(id responseObject, NSError *error) {
        if (!error) {
            self.shippingMethods = responseObject;
        }
        completion(error);
    }];
}


- (void)attachShippingMethod:(MeetsCartShipping *)shippingMethod completion:(MeetsCompletion)completion
{
    MGShoppingCartShippingMethod *shippingCommand = [[MGShoppingCartShippingMethod alloc] initWithCartId:self.objectId];
    [shippingCommand runWithModels:@[shippingMethod] completion:^(id responseObject, NSError *error) {
        if (!error && ![responseObject boolValue]) {
            error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                        code:0
                                    userInfo:[NSDictionary dictionaryWithObject:@"Could not attach shipping method to cart" forKey:NSLocalizedDescriptionKey]];
        }
        
        completion(error);
    }];
}


- (void)fetchPaymentMethodsWithCompletion:(MeetsCompletion)completion
{
#warning TODO:
    @throw [Errors unsupportedOperationException:NSStringFromSelector(_cmd)];
}


- (void)attachPaymentMethod:(MeetsCartPayment *)paymentMethod completion:(MeetsCompletion)completion
{
    MGShoppingCartPaymentMethod *paymentCommand = [[MGShoppingCartPaymentMethod alloc] initWithCartId:self.objectId];
    [paymentCommand runWithModels:@[paymentMethod] completion:^(id responseObject, NSError *error) {
        if (!error && ![responseObject boolValue]) {
            error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                        code:0
                                    userInfo:[NSDictionary dictionaryWithObject:@"Could not attach payment method to cart" forKey:NSLocalizedDescriptionKey]];
        }
        
        completion(error);
    }];
}


- (void)orderWithCompletion:(MeetsCompletion)completion
{
    MGShoppingCartOrder *orderMethod = [MGShoppingCartOrder new];
    [orderMethod runWithParams:@{@"quoteId": self.objectId} filters:nil completion:^(id responseObject, NSError *error) {
        if (!error)
            self.orderId = responseObject;
        
        completion(error);
    }];
}


#pragma mark - Utils

- (MeetsCartItem *)itemWithProductId:(NSNumber *)productId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"productId == %@", productId];
    NSArray *filteredArray = [self.items filteredArrayUsingPredicate:predicate];
    
    if ([filteredArray count] > 0) {
        return filteredArray[0];
    }
    
    return nil;
}

@end
