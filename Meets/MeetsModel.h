//
//  MeetsModel.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 17/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//


@interface MeetsModel : MeetsGenericModel

@property (nonatomic, strong) NSNumber *objectId;


- (instancetype)initWithId:(NSNumber *)theId;

- (void)fillWithModel:(id)modelObject;


@end
