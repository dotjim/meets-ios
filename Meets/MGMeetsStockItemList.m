//
//  MGMeetsStockItemList.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 15/01/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import "MGMeetsStockItemList.h"

@implementation MGMeetsStockItemList

- (instancetype)initWithArrayOfProductsIds:(NSArray *)arrayOfIds
{
    self = [super init];
    if (self)
        self.arrayOfProductIds = arrayOfIds;
    
    return self;
}


- (void)fetchWithCompletion:(MeetsCompletion)completion
{
    MGCatalogInventoryStockItemList *stockMethod = [MGCatalogInventoryStockItemList new];
    [stockMethod runWithParams:@{@"products": self.arrayOfProductIds} filters:nil completion:^(id responseObject, NSError *error) {
        if (!error) {
            NSArray *idsBackup = self.arrayOfProductIds;
            [self fillWithModel:responseObject]; // This nullifies self.arrayOfProductsIds
            self.arrayOfProductIds = idsBackup;
        }
        
        completion(error);
    }];
}

@end
