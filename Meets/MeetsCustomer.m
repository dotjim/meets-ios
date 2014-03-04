//
//  MeetsCustomer.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 14/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsCustomer.h"

@implementation MeetsCustomer

- (void)fetchByEmail:(NSString *)email
          completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (BOOL)checkPassword:(NSString *)password
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)saveWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)fetchAddressesWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)attachAddress:(MeetsAddress *)address
        completion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

@end
