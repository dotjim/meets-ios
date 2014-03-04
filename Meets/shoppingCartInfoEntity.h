//------------------------------------------------------------------------------
// <wsdl2code-generated>
// This code was generated by http://www.wsdl2code.com iPhone version 1.5
// Date Of Creation: 11/5/2013 1:51:25 PM
//
//  Please dont change this code, regeneration will override your changes
//</wsdl2code-generated>
//
//------------------------------------------------------------------------------
//
//This source code was auto-generated by Wsdl2Code Version
//

#import <Foundation/Foundation.h>
#import "shoppingCartAddressEntity.h"
#import "shoppingCartItemEntity.h"
#import "shoppingCartPaymentEntity.h"


@interface shoppingCartInfoEntity : NSObject
{
}
@property (nonatomic, copy) NSString *store_id;
@property (nonatomic, copy) NSString *created_at;
@property (nonatomic, copy) NSString *updated_at;
@property (nonatomic, copy) NSString *converted_at;
@property int quote_id;
@property BOOL quote_idSpecified;
@property int is_active;
@property BOOL is_activeSpecified;
@property int is_virtual;
@property BOOL is_virtualSpecified;
@property int is_multi_shipping;
@property BOOL is_multi_shippingSpecified;
@property double items_count;
@property BOOL items_countSpecified;
@property double items_qty;
@property BOOL items_qtySpecified;
@property (nonatomic, copy) NSString *orig_order_id;
@property (nonatomic, copy) NSString *store_to_base_rate;
@property (nonatomic, copy) NSString *store_to_quote_rate;
@property (nonatomic, copy) NSString *base_currency_code;
@property (nonatomic, copy) NSString *store_currency_code;
@property (nonatomic, copy) NSString *quote_currency_code;
@property (nonatomic, copy) NSString *grand_total;
@property (nonatomic, copy) NSString *base_grand_total;
@property (nonatomic, copy) NSString *checkout_method;
@property (nonatomic, copy) NSString *customer_id;
@property (nonatomic, copy) NSString *customer_tax_class_id;
@property int customer_group_id;
@property BOOL customer_group_idSpecified;
@property (nonatomic, copy) NSString *customer_email;
@property (nonatomic, copy) NSString *customer_prefix;
@property (nonatomic, copy) NSString *customer_firstname;
@property (nonatomic, copy) NSString *customer_middlename;
@property (nonatomic, copy) NSString *customer_lastname;
@property (nonatomic, copy) NSString *customer_suffix;
@property (nonatomic, copy) NSString *customer_note;
@property (nonatomic, copy) NSString *customer_note_notify;
@property (nonatomic, copy) NSString *customer_is_guest;
@property (nonatomic, copy) NSString *applied_rule_ids;
@property (nonatomic, copy) NSString *reserved_order_id;
@property (nonatomic, copy) NSString *password_hash;
@property (nonatomic, copy) NSString *coupon_code;
@property (nonatomic, copy) NSString *global_currency_code;
@property double base_to_global_rate;
@property BOOL base_to_global_rateSpecified;
@property double base_to_quote_rate;
@property BOOL base_to_quote_rateSpecified;
@property (nonatomic, copy) NSString *customer_taxvat;
@property (nonatomic, copy) NSString *customer_gender;
@property double subtotal;
@property BOOL subtotalSpecified;
@property double base_subtotal;
@property BOOL base_subtotalSpecified;
@property double subtotal_with_discount;
@property BOOL subtotal_with_discountSpecified;
@property double base_subtotal_with_discount;
@property BOOL base_subtotal_with_discountSpecified;
@property (nonatomic, copy) NSString *ext_shipping_info;
@property (nonatomic, copy) NSString *gift_message_id;
@property (nonatomic, copy) NSString *gift_message;
@property double customer_balance_amount_used;
@property BOOL customer_balance_amount_usedSpecified;
@property double base_customer_balance_amount_used;
@property BOOL base_customer_balance_amount_usedSpecified;
@property (nonatomic, copy) NSString *use_customer_balance;
@property (nonatomic, copy) NSString *gift_cards_amount;
@property (nonatomic, copy) NSString *base_gift_cards_amount;
@property (nonatomic, copy) NSString *gift_cards_amount_used;
@property (nonatomic, copy) NSString *use_reward_points;
@property (nonatomic, copy) NSString *reward_points_balance;
@property (nonatomic, copy) NSString *base_reward_currency_amount;
@property (nonatomic, copy) NSString *reward_currency_amount;
@property (nonatomic, strong) shoppingCartAddressEntity *shipping_address;
@property (nonatomic, strong) shoppingCartAddressEntity *billing_address;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) shoppingCartPaymentEntity *payment;

-(NSString*)toString:(BOOL)addNameWrap;
-(id)initWithArray:(NSArray*)array;
-(void)encodeWithCoder:(NSCoder *)encoder;
-(id)copyWithZone:(NSZone *)zone;
-(id)initWithCoder:(NSCoder *)decoder;
@end
