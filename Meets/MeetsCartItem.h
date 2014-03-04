//
//  MeetsCartItem.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 13/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsModel.h"

@interface MeetsCartItem : NSObject

@property (nonatomic, strong) NSNumber *productId;
@property (nonatomic, strong) NSString *productSku;
@property (nonatomic, strong) NSNumber *quantity;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) MeetsProduct *relatedProduct;

- (instancetype)initWithProduct:(MGMeetsProduct *)aProduct;


@end
