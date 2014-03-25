//
//  MGMeetsCollection.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 12/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGMeetsCollection.h"

@implementation MGMeetsCollection

- (void)fetchWithCompletion:(MeetsCompletion)completion
{
    ApiMethod *method = [NSClassFromString(self.apiMethod) new];
    
    if ([method isKindOfClass:[RestApiMethod class]])
    {
        NSMutableDictionary *allFilters = [NSMutableDictionary dictionaryWithDictionary:@{@"page":self.page, @"limit": self.pageSize}];
        [allFilters addEntriesFromDictionary:self.filters];
        [(RestApiMethod *)method runWithParams:nil filters:allFilters completion:^(id responseObject, NSError *error) {
            if (!error)
                [self fillWithModel:responseObject];
            
            completion(error);
        }];
    }
    else
    {
#warning TODO: soap collections
        @throw [Errors unsupportedOperationException:NSStringFromSelector(_cmd)];
    }
}


- (void)fillWithModel:(id)modelObject
{    
    for (MeetsProduct *product in [modelObject collection]) {
        [self insertModel:product]; // insertModel: avoids possible duplicates
    }
}


@end
