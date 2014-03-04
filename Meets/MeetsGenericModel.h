//
//  MeetsGenericModel.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 28/02/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import <Foundation/Foundation.h>

@interface MeetsGenericModel : NSObject

#warning TODO include support:
@property (nonatomic, strong) NSArray *include;


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder;

- (void)encodeWithCoder:(NSCoder *)encoder;


#pragma mark -

- (void)fetchWithCompletion:(MeetsCompletion)completion;


@end
