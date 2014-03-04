//
//  NSObject+Instrospection.m
//
//  Created by Juan Fernández Sagasti on 18/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "NSObject+Instrospection.h"
#import <objc/runtime.h>

@implementation NSObject (Instrospection)

- (NSArray *)classProperties
{
    if ([self.class isEqual:[NSObject class]])
    {
        return [NSArray array]; // empty
    }

    u_int count;
    objc_property_t *properties = class_copyPropertyList(self.class, &count);
    NSMutableArray *propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char *propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    free(properties);
    
    // Also map any super classes:
    Class superClass = class_getSuperclass(self.class);
    [propertyArray addObjectsFromArray:[superClass classProperties]];
    
    return propertyArray;
}

@end
