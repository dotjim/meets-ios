//
//  MeetsStockItem.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 16/01/14.
//  Original work Copyright (c) 2014 TheAgileMonkeys.
//

#import "MeetsModel.h"

@interface MeetsStockItem : MeetsModel

@property (nonatomic, strong) NSNumber *productId;
@property (nonatomic, strong) NSString *sku;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSNumber *isInStock;

@end
