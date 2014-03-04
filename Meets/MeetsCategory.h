//
//  MeetsCategory.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 11/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsModel.h"

@interface MeetsCategory : MeetsModel

@property (nonatomic, strong) NSNumber *parentId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSNumber *isActive;
@property (nonatomic, strong) NSNumber *position;
@property (nonatomic, strong) NSNumber *level;
@property (nonatomic, strong) NSMutableArray *children;


- (void)fetchChildrenWithCompletion:(MeetsCompletion)completion;

- (void)fetchWithDescendantsWithCompletion:(MeetsCompletion)completion;

@end
