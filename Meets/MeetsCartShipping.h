//
//  MeetsCartShipping.h
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 27/11/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "MeetsModel.h"

@interface MeetsCartShipping : MeetsModel

@property (nonatomic, strong) NSString *code;
@property (nonatomic, strong) NSString *carrierTitle;
@property (nonatomic, strong) NSString *carrierCode;
//@property (nonatomic, strong) NSString *method;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, strong) NSNumber *price;

@end
