//
//  MGMeetsAddress.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 26/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGMeetsAddress.h"

@implementation MGMeetsAddress

- (void)saveWithCompletion:(MeetsCompletion)completion
{
    MGCustomerAddressUpdate *updateMethod = [MGCustomerAddressUpdate new];
    [updateMethod runWithModels:@[self] completion:^(id responseObject, NSError *error) {
        if (!error && ![responseObject boolValue]) {
            error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                        code:0
                                    userInfo:[NSDictionary dictionaryWithObject:@"Could not update the address" forKey:NSLocalizedDescriptionKey]];
        }
        
        completion(error);    }];
}


- (void)removeWithCompletion:(MeetsCompletion)completion
{
    MGCustomerAddressDelete *updateMethod = [MGCustomerAddressDelete new];
    [updateMethod runWithModels:@[self.objectId] completion:^(id responseObject, NSError *error) {
        if (!error && ![responseObject boolValue]) {
            error = [NSError errorWithDomain:@"MagentoErrorDomain"
                                        code:0
                                    userInfo:[NSDictionary dictionaryWithObject:@"Could not remove the address" forKey:NSLocalizedDescriptionKey]];
        }
        
        completion(error);
    }];
}

@end
