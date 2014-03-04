//
//  MeetsAddress.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 26/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsModel.h"

@interface MeetsAddress : MeetsModel <NSCoding>

@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *street;
@property (nonatomic, strong) NSString *city;
@property (nonatomic, strong) NSString *region;
@property (nonatomic, strong) NSString *regionId;
@property (nonatomic, strong) NSString *postCode;
@property (nonatomic, strong) NSString *countryId;
@property (nonatomic, strong) NSString *telephone;
@property (nonatomic, strong) NSNumber *isDefaultBilling;
@property (nonatomic, strong) NSNumber *isDefaultShipping;
@property (nonatomic, strong) NSString *company;
@property (nonatomic, strong) NSString *fax;

- (void)saveWithCompletion:(MeetsCompletion)completion;

- (void)removeWithCompletion:(MeetsCompletion)completion;

@end
