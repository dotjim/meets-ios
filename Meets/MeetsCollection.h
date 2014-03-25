//
//  MeetsCollection.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 12/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import <Foundation/Foundation.h>

@interface MeetsCollection : MeetsGenericModel

@property (nonatomic, strong) NSMutableArray *collection;
@property (nonatomic, strong) NSDictionary *filters;

@property (nonatomic, strong) NSNumber *page;
@property (nonatomic, strong) NSNumber *pageSize;
@property (nonatomic, strong) NSNumber *resetOnFetch;

@property (nonatomic, strong, readonly) NSString *apiMethod;

- (instancetype)initWithApiMethodClass:(Class)method;

- (void)reset;

- (void)insertModel:(MeetsModel *)model;

- (MeetsModel *)extractModelWithId:(NSNumber *)modelId;

@end
