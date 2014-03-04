//
//  MeetsStockItemList.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 07/01/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import "MeetsModel.h"

@interface MeetsStockItemList : MeetsModel

@property (nonatomic, strong) NSArray *arrayOfProductIds;
@property (nonatomic, strong) NSArray *productsInStock;

- (instancetype)initWithArrayOfProductsIds:(NSArray *)arrayOfIds;

@end
