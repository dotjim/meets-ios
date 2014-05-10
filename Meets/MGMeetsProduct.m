//
//  MGMeetsProduct.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 21/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MGMeetsProduct.h"

@implementation MGMeetsProduct

- (void)fetchWithCompletion:(MeetsCompletion)completion
{
    MGProduct *productsMethod = [MGProduct new];
    [productsMethod runWithParams:@[self.objectId] filters:nil completion:^(id responseObject, NSError *error) {
        if (!error)
            [self fillWithModel:responseObject];
        
        completion(error);
    }];
}


- (void)fetchAssociatedProductsWithCompletion:(MeetsCompletion)completion
{
    associativeEntity *filterValue = [associativeEntity new];
    filterValue.key = @"like";
    filterValue.value = [self.sku stringByAppendingString:@"-%"];
    
    complexFilter *aComplexFilter = [complexFilter new];
    aComplexFilter.key = @"sku";
    aComplexFilter.value = filterValue;
    
    filters *soapFilters = [filters new];
    soapFilters.complex_filter = [NSMutableArray arrayWithObject:aComplexFilter];
    
    MGCatalogProductList *productListMethod = [MGCatalogProductList new];
    [productListMethod runWithParams:nil filters:soapFilters completion:^(id responseObject, NSError *error) {
        self.associatedProducts = responseObject;
        completion(error);
    }];
    
}


- (void)fetchWithAdditionalAttributes:(NSArray *)attributes completion:(MeetsCompletion)completion
{
    MGCatalogProductInfo *infoMethod = [MGCatalogProductInfo new];
    [infoMethod runWithParams:@{@"product": self.sku, @"attributes": [NSArray arrayWithObject:@{@"additional_attributes": attributes}]} filters:nil completion:^(id responseObject, NSError *error) {
        if (!error) {
            [self fillWithModel:responseObject];
            
            __block NSError *completionError = nil;
            
            dispatch_group_t group = dispatch_group_create();

            // Options caching
            for (NSString *attributeKey in attributes)
            {
                dispatch_group_enter(group);

                id object = [[NSUserDefaults standardUserDefaults] valueForKey:[@"MeetsSDK:" stringByAppendingString:attributeKey]];
                if (object) { // Try to retrieve options from cache (NSUserDefaults)
                    dispatch_group_leave(group);
                } else {
                    MGCatalogProductAttributeOptions *attributeOptionsMethod = [MGCatalogProductAttributeOptions new];
                    [attributeOptionsMethod runWithParams:@{@"attributeId": attributeKey} filters:nil completion:^(id responseObject, NSError *error) {
                        if (!error)
                        {
                            NSMutableArray *attributesArray = [NSMutableArray array];
                            
                            for (catalogAttributeOptionEntity *anOption in responseObject)
                            {
                                if (anOption.value && anOption.label)
                                    [attributesArray addObject:@{anOption.value: anOption.label}];
                            }
                            
                            [[NSUserDefaults standardUserDefaults] setObject:attributesArray forKey:[@"MeetsSDK:" stringByAppendingString:attributeKey]];
                            [[NSUserDefaults standardUserDefaults] synchronize];
                        }
                        else {
                            completionError = error;
                        }
                        
                        dispatch_group_leave(group);
                    }];
                }
            }
            
            dispatch_group_notify(group, dispatch_get_main_queue(), ^{
                // All requests finished
                if (completionError) {
                    self.additionalAttributes = nil;
                }
                else {
                    NSMutableDictionary *finalDictionary = [NSMutableDictionary dictionary];
                    
                    for (NSString *aKey in self.additionalAttributes.allKeys) {
                        id value = [self valueForAdditionalAttributeDictionary:[self.additionalAttributes dictionaryWithValuesForKeys:@[aKey]]];
                        
                        if (value) {
                            [finalDictionary addEntriesFromDictionary:@{aKey: value}];
                        }
                    }
                    self.additionalAttributes = finalDictionary;
                }
                completion(completionError);
            });
        }
        else {
            completion(error);
        }
    }];
}


- (void)fetchImageVersionsWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors unsupportedOperationException:NSStringFromSelector(_cmd)];
}


#pragma mark - Private methods

- (id)valueForAdditionalAttributeDictionary:(NSDictionary *)attributeDict
{
    NSString *key = [attributeDict allKeys][0]; // Must have 1 key only
    id value = [attributeDict allValues][0]; // Array of dictionaries
    
    for (NSDictionary *aDict in [[NSUserDefaults standardUserDefaults] valueForKey:[@"MeetsSDK:" stringByAppendingString:key]])
    {
        id finalValue = [aDict valueForKey:value];
        if (finalValue)
            return finalValue;
    }
    
    return nil;
}

@end
