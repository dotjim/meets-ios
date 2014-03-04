//
//  MGMeetsAddress.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 26/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsAddress.h"

static NSString *kAddressModeTypeBilling = @"billing";
static NSString *kAddressModeTypeShipping = @"shipping";

@interface MGMeetsAddress : MeetsAddress

@property (nonatomic, strong) NSString *mode;

@end
