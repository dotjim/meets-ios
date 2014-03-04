//
//  MGCatalogCategory.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 18/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGCatalogCategory.h"

@implementation MGCatalogCategory

- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    MeetsCategory *categoryModel = [[MeetsFactory shared] makeCategoryWithId:nil];
    
    if (![responseObject isKindOfClass:[NSArray class]])
    {
        if ([responseObject isKindOfClass:[NSNull class]])
        {
            return nil;
        }
        responseObject = [NSArray arrayWithObject:responseObject];
    }
    
    for (id anObject in responseObject)
    {
        if ([anObject class] == [NSNull class]) continue;
        
        categoryModel.name = [[anObject valueForKey:@"name"] capitalizedString];
        categoryModel.objectId = @([[anObject valueForKey:@"category_id"] integerValue]);
        categoryModel.parentId = @([[anObject valueForKey:@"parent_id"] integerValue]);
        categoryModel.level = @([[anObject valueForKey:@"level"] integerValue]);
        
        if ([anObject respondsToSelector:@selector(is_active)]) // EntityNoChildren
            categoryModel.isActive = [anObject valueForKey:@"is_active"];
        
        if ([anObject respondsToSelector:@selector(children)])
        {
            categoryModel.children = [NSMutableArray array];
            for (id aChild in [anObject valueForKey:@"children"])
            {
                id children = [self mapResponseToModelObjectWithResponse:aChild];
                if (children)
                {
                    [categoryModel.children addObject:[self mapResponseToModelObjectWithResponse:aChild]];
                }
            }
        }
    }
    return categoryModel;
}

@end
