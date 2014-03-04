//
//  MeetsCustomer.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 14/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsModel.h"

@interface MeetsCustomer : MeetsModel <NSCoding>

@property (nonatomic, strong) NSString *email;
@property (nonatomic, strong) NSString *firstName;
@property (nonatomic, strong) NSString *lastName;
@property (nonatomic, strong) NSString *vatNumber;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, strong) NSString *passwordHash;
@property (nonatomic, strong) NSMutableArray *addresses;


- (void)fetchByEmail:(NSString *)email
          completion:(MeetsCompletion)completion;

- (BOOL)checkPassword:(NSString *)password;

- (void)saveWithCompletion:(MeetsCompletion)completion;

- (void)fetchAddressesWithCompletion:(MeetsCompletion)completion;

- (void)attachAddress:(MeetsAddress *)address
        completion:(MeetsCompletion)completion;

@end
