//
//  ModelCollection.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 12/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsCollection.h"

@implementation MeetsCollection


- (instancetype)initWithApiMethodClass:(Class)method
{
    self = [super init];
    if (self)
    {
        _apiMethod = method;
        self.collection = [NSMutableArray array];
        self.page = @(0);
        self.pageSize = @(50); // Default
    }
    return self;
}


- (void)reset
{
    self.filters = nil;
    self.page = @(0);
    [self.collection removeAllObjects];
}


- (void)fetchWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (void)fillWithModel:(id)modelObject
{
    if (self.resetOnFetch.boolValue) {
        self.collection = [modelObject collection];
    } else {
        [self.collection addObjectsFromArray:[modelObject collection]];
    }
}


- (void)insertModel:(MeetsModel *)model
{
    if (!self.collection) {
        self.collection = [NSMutableArray array];
    }
    
    // Avoids duplicates:
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %@", model.objectId];
    NSArray *filteredArray = [self.collection filteredArrayUsingPredicate:predicate];
    if (filteredArray.count == 0) {
        [self.collection addObject:model];
    }
}


- (MeetsModel *)extractModelWithId:(NSNumber *)modelId
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"objectId == %@", modelId];
    NSArray *filteredArray = [self.collection filteredArrayUsingPredicate:predicate];
    if (filteredArray.count > 0) {
        [self.collection removeObject:filteredArray[0]];
        return filteredArray[0];
    }
    return nil;
}



@end
