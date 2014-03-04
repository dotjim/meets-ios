//
//  MGMeetsFactory.m
//  Aristocrazy
//
//  Created by Juan Fernández Sagasti on 21/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGMeetsFactory.h"

@implementation MGMeetsFactory

#pragma mark - Products

- (MeetsProduct *)makeProductWithId:(NSNumber *)theId
{
    return [[MGMeetsProduct alloc] initWithId:theId];
}

- (MeetsCollection *)makeProductCollection
{
    return [[MGMeetsCollection alloc] initWithApiMethodClass:[MGProducts class]];
}


#pragma mark - Categories

- (MeetsCategory *)makeCategoryWithId:(NSNumber *)theId
{
    return [[MGMeetsCategory alloc] initWithId:theId];
}


#pragma mark - Carts

- (MeetsCart *)makeCart
{
    return [MGMeetsCart new];
}

- (MeetsCart *)makeCartWithId:(NSNumber *)theId
{
    return [[MGMeetsCart alloc] initWithId:theId];
}

- (MeetsCartItem *)makeCartItemWithProduct:(MeetsProduct *)product
{
    return [[MGMeetsCartItem alloc] initWithProduct:(MGMeetsProduct *)product];
}


#pragma mark - Customers

- (MeetsCustomer *)makeCustomer
{
    return [MGMeetsCustomer new];
}

- (MeetsCustomer *)makeCustomerWithId:(NSNumber *)theId
{
    return [[MGMeetsCustomer alloc] initWithId:theId];
}


- (MeetsCollection *)makeCustomerCollection
{
    @throw [Errors unsupportedOperationException:NSStringFromSelector(_cmd)];
}


#pragma mark - Addresses

- (MeetsAddress *)makeAddress
{
    return [MGMeetsAddress new];
}

- (MeetsAddress *)makeAddressWithId:(NSNumber *)theId
{
    return [[MGMeetsAddress alloc] initWithId:theId];
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
    return [[MGMeetsStockItemList alloc] initWithArrayOfProductsIds:idsArray];
}


@end
