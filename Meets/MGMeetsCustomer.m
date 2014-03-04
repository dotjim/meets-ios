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
    }];}


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


- (void)attachAddress:(MeetsAddress *)address completion:(MeetsCompletion)completion
{
    MGCustomerAddressCreate *createMethod = [[MGCustomerAddressCreate alloc] initWithCustomerId:self.objectId];
    [createMethod runWithModels:@[address] completion:^(id responseObject, NSError *error) {
        if (!error) {
            address.objectId = @([responseObject integerValue]);
        }
        completion(error);
    }];
}


@end
