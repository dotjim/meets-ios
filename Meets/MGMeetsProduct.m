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
    MGProducts *productsMethod = [MGProducts new];
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


- (void)fetchAdditionalAttributes:(NSDictionary *)attributes completion:(MeetsCompletion)completion
{
    @throw [Errors unsupportedOperationException:NSStringFromSelector(_cmd)];

 
#warning TODO:
//    MGCatalogProductInfo *infoMethod = [MGCatalogProductInfo new];
//    [infoMethod runWithParams:attributes filters:nil completion:^(id responseObject, NSError *error) {
//        if (!error)
//            [self fillWithModel:responseObject];
//        
//        completion(error);
//    }];
}


- (void)fetchImageVersionsWithCompletion:(MeetsCompletion)completion
{
    @throw [Errors unsupportedOperationException:NSStringFromSelector(_cmd)];
}



@end
