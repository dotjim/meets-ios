//
//  MeetsFactory.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 21/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import <Foundation/Foundation.h>

@interface MeetsFactory : NSObject

@property (nonatomic, strong) MeetsFactory *sharedFactory;

#pragma mark -
+ (MeetsFactory *)shared;

+ (void)initWithFactory:(MeetsFactory *)factory;


#pragma mark - Produts
- (MeetsProduct *)makeProductWithId:(NSNumber *)theId;

- (MeetsCollection *)makeProductCollection;


#pragma mark - Categories

- (MeetsCategory *)makeCategoryWithId:(NSNumber *)theId;


#pragma mark - Carts

- (MeetsCart *)makeCart;

- (MeetsCart *)makeCartWithId:(NSNumber *)theId;

- (MeetsCartItem *)makeCartItemWithProduct:(MeetsProduct *)product;


#pragma mark - Customers

- (MeetsCustomer *)makeCustomer;

- (MeetsCustomer *)makeCustomerWithId:(NSNumber *)theId;

- (MeetsCollection *)makeCustomerCollection;


#pragma mark - Addresses

- (MeetsAddress *)makeAddress;

- (MeetsAddress *)makeAddressWithId:(NSNumber *)theId;


#pragma mark - Payments

- (MeetsCartPayment *)makeCartPayment;


#pragma mark - Shippings

- (MeetsCartShipping *)makeCartShipping;


#pragma mark - Stock list

- (MeetsStockItemList *)makeItemListWithIds:(NSArray *)idsArray;

@end
