//
//  MeetsCartPayment.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 28/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsModel.h"

@interface MeetsCartPayment : MeetsModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *code; //method = code
@property (nonatomic, strong) NSString *poNumber;
@property (nonatomic, strong) NSString *ccCid;
@property (nonatomic, strong) NSString *ccOwner;
@property (nonatomic, strong) NSString *ccNumber;
@property (nonatomic, strong) NSString *ccType;
@property (nonatomic, strong) NSString *ccExpirationYear;
@property (nonatomic, strong) NSString *ccExpirationMonth;
@property (nonatomic, strong) NSString *token;

@end
