//
//  Meets.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 16/12/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import <Foundation/Foundation.h>

// Blocks
typedef void(^RequestCompletion)(id responseObject, NSError *error);
typedef void(^MeetsCompletion)(NSError *error);

// Errors
#import "Errors.h"

// Categories
#import "NSObject+Instrospection.h"

// Networking
#import "MeetsRestSessionManager.h"
#import "MeetsSoapSessionManager.h"

// SOAP objects
#import "shoppingCartProductEntity.h"
#import "catalogProductEntity.h"
#import "shoppingCartInfoEntity.h"
#import "shoppingCartCustomerEntity.h"
#import "shoppingCartCustomerAddressEntity.h"
#import "shoppingCartShippingMethodEntity.h"
#import "shoppingCartPaymentMethodEntity.h"
#import "customerCustomerEntity.h"
#import "customerCustomerEntityToCreate.h"
#import "filters.h"
#import "complexFilter.h"
#import "associativeEntity.h"
#import "customerAddressEntityItem.h"
#import "customerAddressEntityCreate.h"
#import "catalogProductReturnEntity.h"
#import "catalogProductRequestAttributes.h"
#import "catalogAttributeOptionEntity.h"
#import "catalogInventoryStockItemEntity.h"


// Api Methods
#import "ApiMethod.h"
#import "RestApiMethod.h"
#import "SoapApiMethod.h"
#import "MGProducts.h"
#import "MGLogin.h"
#import "MGCatalogCategory.h"
#import "MGCatalogCategoryLevel.h"
#import "MGCatalogCategoryTree.h"
#import "MGShoppingCartCreate.h"
#import "MGShoppingCartInfo.h"
#import "MGShoppingCartProductAdd.h"
#import "MGShoppingCartProductRemove.h"
#import "MGShoppingCartProductList.h"
#import "MGShoppingCartCustomerSet.h"
#import "MGShoppingCartCustomerAddresses.h"
#import "MGShoppingCartShippingList.h"
#import "MGShoppingCartShippingMethod.h"
#import "MGShoppingCartPaymentMethod.h"
#import "MGShoppingCartOrder.h"
#import "MGCustomerCustomerList.h"
#import "MGCustomerAddressList.h"
#import "MGCustomerAddressCreate.h"
#import "MGCustomerAddressUpdate.h"
#import "MGCustomerAddressDelete.h"
#import "MGCustomerCustomerCreate.h"
#import "MGCustomerCustomerUpdate.h"
#import "MGCatalogProductList.h"
#import "MGCatalogProductInfo.h"
#import "MGCatalogProductAttributeOptions.h"
#import "MGCatalogInventoryStockItemList.h"


// Models
#import "MeetsGenericModel.h"
#import "MGMeetsProduct.h"
#import "MGMeetsCategory.h"
#import "MeetsCollection.h"
#import "MGMeetsCollection.h"
#import "MGMeetsCartItem.h"
#import "MeetsAddress.h"
#import "MGMeetsAddress.h"
#import "MeetsCustomer.h"
#import "MGMeetsCustomer.h"
#import "MeetsCartShipping.h"
#import "MGMeetsCartShipping.h"
#import "MeetsCartPayment.h"
#import "MGMeetsCartPayment.h"
#import "MeetsCart.h"
#import "MGMeetsCart.h"
#import "MeetsStockItem.h"
#import "MGMeetsStockItem.h"
#import "MeetsStockItemList.h"
#import "MGMeetsStockItemList.h"
#import "MeetsFactory.h"
#import "MGMeetsFactory.h"

// Init
#import "Meets.h"

// Frameworks
#import "XPathQuery.h"

@interface Meets : NSObject

+ (void)initWithFactory:(MeetsFactory *)factory
                hostUrl:(NSString *)url
            soapApiUser:(NSString *)apiUser
        soapApiPassword:(NSString *)apiPassword;

+ (void)initWithFactory:(MeetsFactory *)factory
                hostUrl:(NSString *)url
            soapApiUser:(NSString *)apiUser
        soapApiPassword:(NSString *)apiPassword
                storeId:(NSString *)storeId
              websiteId:(NSString *)websiteId;

+ (void)initWithFactory:(MeetsFactory *)factory
                hostUrl:(NSString *)url
            soapApiUser:(NSString *)apiUser
        soapApiPassword:(NSString *)apiPassword
                storeId:(NSString *)storeId
              websiteId:(NSString *)websiteId
          basicAuthUser:(NSString *)serverUser
      basicAuthPassword:(NSString *)serverPassword;

@end
