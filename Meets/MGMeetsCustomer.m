//
//  MGMeetsCustomer.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 14/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGMeetsCustomer.h"
#import "NSString+NSHash.h"

@implementation MGMeetsCustomer

- (id)initWithId:(NSNumber *)customerId
{
    self = [super init];
    if (self)
    {
        self.objectId = customerId;
        self.type = @"customer";
    }
    return self;
}


- (void)fetchByEmail:(NSString *)email
          completion:(MeetsCompletion)completion
{
    MGCustomerCustomerList *customerListMethod = [MGCustomerCustomerList new];
    
    associativeEntity *filterValue = [associativeEntity new];
    filterValue.key = @"eq";
    filterValue.value = email;
    
    complexFilter *aComplexFilter = [complexFilter new];
    aComplexFilter.key = @"email";
    aComplexFilter.value = filterValue;
    
    filters *soapFilters = [filters new];
    soapFilters.complex_filter = [NSMutableArray arrayWithObject:aComplexFilter];
    
    [customerListMethod runWithParams:nil filters:soapFilters completion:^(id responseObject, NSError *error) {
        if (!error && [responseObject count] > 0) {
            [self fillWithModel:responseObject[0]];
        }

        completion(error);
    }];
}


- (BOOL)checkPassword:(NSString *)password
{
    NSRange saltPosition = [self.passwordHash rangeOfString:@":"];
    NSString *saltNoise = [self.passwordHash substringFromIndex:saltPosition.location+1];
    NSString *typedPasswordHash = [[saltNoise stringByAppendingString:password] MD5];
    
    return ([typedPasswordHash isEqualToString:[self.passwordHash substringToIndex:saltPosition.location]]) ? YES : NO;
}


- (void)saveWithCompletion:(MeetsCompletion)completion
{
    if (self.objectId) { // Update else create
        MGCustomerCustomerUpdate *updateMethod = [MGCustomerCustomerUpdate new];
        [updateMethod runWithModels:@[self] completion:^(id responseObject, NSError *error) {
            if (!error && ![responseObject boolValue]) {
                error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                            code:0
                                        userInfo:[NSDictionary dictionaryWithObject:@"Could not update the customer" forKey:NSLocalizedDescriptionKey]];
            }
            completion(error);
        }];
    } else {
        MGCustomerCustomerCreate *createMethod = [MGCustomerCustomerCreate new];
        [createMethod runWithModels:@[self] completion:^(id responseObject, NSError *error) {
            if (!error)
                self.objectId = responseObject;
            
            completion(error);
        }];
    }
}


- (void)fetchAddressesWithCompletion:(MeetsCompletion)completion
{
    MGCustomerAddressList *addressListMethod = [MGCustomerAddressList new];
    [addressListMethod runWithParams:@{@"customerId": self.objectId} filters:nil completion:^(id responseObject, NSError *error) {
        self.addresses = responseObject;
        completion(error);
    }];
}


- (void)saveAddress:(MeetsAddress *)address
         completion:(MeetsCompletion)completion
{
    MeetsAddress *addressToSend = [self addressWithId:address.objectId];
    
    if (addressToSend) { // Update-else-create
        MGCustomerAddressUpdate *updateMethod = [MGCustomerAddressUpdate new];
        [updateMethod runWithModels:@[address] completion:^(id responseObject, NSError *error) {
            if (!error) {
                if ([responseObject boolValue]) {
                    [addressToSend fillWithModel:address];
                    [self updateBillingsAndShippingsWithAddress:address];
                }
                else {
                    error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                                code:0
                                            userInfo:[NSDictionary dictionaryWithObject:@"Could not update the address" forKey:NSLocalizedDescriptionKey]];
                }
            }
            
            completion(error);
        }];
    }
    else {
        MGCustomerAddressCreate *createMethod = [[MGCustomerAddressCreate alloc] initWithCustomerId:self.objectId];
        [createMethod runWithModels:@[address] completion:^(id responseObject, NSError *error) {
            if (!error) {
                [self updateBillingsAndShippingsWithAddress:address];
                address.objectId = @([responseObject integerValue]);
                [self.addresses addObject:address];
            }
            completion(error);
        }];
    }
}


- (void)removeAddressWithId:(NSNumber *)addressId
                 completion:(MeetsCompletion)completion
{
    MGCustomerAddressDelete *deleteMethod = [MGCustomerAddressDelete new];
    [deleteMethod runWithModels:@[addressId] completion:^(id responseObject, NSError *error) {
        if (!error) {
            if ([responseObject boolValue]) {
                [self.addresses removeObject:[self addressWithId:addressId]];
            }
            else {
                error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                            code:0
                                        userInfo:[NSDictionary dictionaryWithObject:@"Could not remove the address" forKey:NSLocalizedDescriptionKey]];
            }
        }
        
        completion(error);
    }];
}


#pragma mark - Private methods

- (void)updateBillingsAndShippingsWithAddress:(MeetsAddress *)address
{
    // Update the default billing and shipping state in the other addresses
    for (MeetsAddress *anAddress in self.addresses) {
        if (address.isDefaultBilling.boolValue && anAddress.isDefaultBilling.boolValue && (![address.objectId isEqual:anAddress.objectId])) {
            anAddress.isDefaultBilling = @NO;
        }
        
        if (address.isDefaultShipping.boolValue && anAddress.isDefaultShipping.boolValue && (![address.objectId isEqual:anAddress.objectId])) {
            anAddress.isDefaultShipping = @NO;
        }
    }
}

- (MeetsAddress *)addressWithId:(NSNumber *)addressId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %@", addressId];
    NSArray *filteredArray = [self.addresses filteredArrayUsingPredicate:predicate];
    
    if ([filteredArray count] > 0) {
        return filteredArray[0];
    }
    
    return nil;
}


@end
