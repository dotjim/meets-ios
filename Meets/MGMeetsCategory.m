//
//  MGMeetsCategory.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 11/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGMeetsCategory.h"

@implementation MGMeetsCategory

- (void)fetchWithCompletion:(MeetsCompletion)completion
{
#warning TODO:
    @throw [Errors unsupportedOperationException:NSStringFromSelector(_cmd)];
}


- (void)fetchWithDescendantsWithCompletion:(MeetsCompletion)completion
{
    if (!self.parentId)
        self.parentId = self.objectId;
    
    [[MGCatalogCategoryTree new] runWithParams:@{@"parentId": self.parentId}
                                       filters:nil
                                    completion:^(id responseObject, NSError *error) {
        if (!error) {
            [self fillWithModel:responseObject];
        }
        completion(error);
    }];
}


#warning TODO: not tested
- (void)fetchChildrenWithCompletion:(MeetsCompletion)completion
{
    if (!self.parentId)
        self.parentId = self.objectId;
    
    [[MGCatalogCategoryLevel new] runWithParams:@{@"parentCategory": self.parentId}
                                        filters:nil
                                     completion:^(id responseObject, NSError *error) {
        if (!error) {
            [self fillWithModel:responseObject];
        }
        completion(error);
    }];
}


@end
