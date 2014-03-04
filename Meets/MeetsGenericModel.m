//
//  MeetsGenericModel.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 28/02/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import "MeetsGenericModel.h"

@implementation MeetsGenericModel


#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)decoder
{
    if (self = [super init])
    {
        for (NSString *aProperty in [self classProperties]) // Introspection category
            [self setValue:[decoder decodeObjectForKey:aProperty] forKey:aProperty];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)encoder
{
    for (NSString *aProperty in [self classProperties])
        [encoder encodeObject:[self valueForKey:aProperty] forKey:aProperty];
}


#pragma mark -

- (void)fetchWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

@end
