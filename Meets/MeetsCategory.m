//
//  MeetsCategory.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 11/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsCategory.h"

@implementation MeetsCategory

- (void)fetchChildrenWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)fetchWithDescendantsWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

@end
