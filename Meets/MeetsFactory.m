//
//  MeetsFactory.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 21/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsFactory.h"

@implementation MeetsFactory


#pragma mark - Class

static MeetsFactory *shared = nil;

+ (MeetsFactory *)shared
{
    return shared;
}

+ (void)initWithFactory:(MeetsFactory *)factory
{
    shared = factory;
}


#pragma mark - Products

- (MeetsProduct *)makeProductWithId:(NSNumber *)theId
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

- (MeetsCollection *)makeProductCollection
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


#pragma mark - Categories

- (MeetsCategory *)makeCategoryWithId:(NSNumber *)theId
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


#pragma mark - Carts

- (MeetsCart *)makeCart
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

- (MeetsCart *)makeCartWithId:(NSNumber *)theId
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

- (MeetsCartItem *)makeCartItemWithProduct:(MeetsProduct *)product
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


#pragma mark - Customers

- (MeetsCustomer *)makeCustomer
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

- (MeetsCustomer *)makeCustomerWithId:(NSNumber *)theId
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (MeetsCollection *)makeCustomerCollection
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


#pragma mark - Addresses

- (MeetsAddress *)makeAddress
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

- (MeetsAddress *)makeAddressWithId:(NSNumber *)theId
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


#pragma mark - Payments

- (MeetsCartPayment *)makeCartPayment
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


#pragma mark - Shippings

- (MeetsCartShipping *)makeCartShipping
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


#pragma mark - Stock list

- (MeetsStockItemList *)makeItemListWithIds:(NSArray *)idsArray
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

@end
