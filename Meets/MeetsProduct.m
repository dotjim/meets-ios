//
//  ProductModel.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 21/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsProduct.h"

@implementation MeetsProduct


- (void)fetchAssociatedProductsWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];

}


- (void)fetchWithAdditionalAttributes:(NSArray *)attributes
                           completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)fetchImageVersionsWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


@end
