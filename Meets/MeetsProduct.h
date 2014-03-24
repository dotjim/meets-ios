//
//  MeetsProduct.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 21/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsModel.h"

@interface MeetsProduct : MeetsModel

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *sku;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSNumber *price;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSDictionary *images;

/**
 *  Dictionary of type @{NSString: NSString}
 */
@property (nonatomic, strong) NSDictionary *additionalAttributes;

@property (nonatomic, strong) NSMutableArray *associatedProducts;


- (void)fetchAssociatedProductsWithCompletion:(MeetsCompletion)completion;

- (void)fetchWithAdditionalAttributes:(NSArray *)attributes
                           completion:(MeetsCompletion)completion;

- (void)fetchImageVersionsWithCompletion:(MeetsCompletion)completion;

@end
