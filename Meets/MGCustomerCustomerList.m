//
//  MGCustomerCustomerList.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 20/12/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

@implementation MGCustomerCustomerList

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.methodName = @"customerCustomerList";
    }
    
    return self;
}


- (id)parseResponseFromXmlString:(NSString *)xml
{
    NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"urn:Magento\"" withString:@""];
    NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
    XPathQuery *xpathQuery = [[XPathQuery alloc] init];
    NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
    NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
    NSMutableArray *result = nil;
    if([arrayOfWSData count] > 0)
    {
        result = [[NSMutableArray alloc] init];
        NSArray* array30 = [[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeChildArray"];
        NSUInteger arraySize = [array30 count];
        for (int j=0;j<arraySize;j++)
        {
            NSArray* array31 = [[array30 objectAtIndex:j] objectForKey:@"nodeChildArray"];
            customerCustomerEntity *itemResult = [[customerCustomerEntity alloc] initWithArray:array31];
            [result addObject:itemResult];
        }
    }
    
    return result;
}


- (id)mapResponseToModelObjectWithResponse:(id)responseObject
{
    if ([responseObject count] == 0) return nil;
    
    NSMutableArray *items = [NSMutableArray array];
    for (customerCustomerEntity *aCustomer in responseObject)
    {
        MGMeetsCustomer *customer = [[MGMeetsCustomer alloc] initWithId:@(aCustomer.customer_id)];
        customer.email = aCustomer.email;
        customer.firstName = aCustomer.firstname;
        customer.lastName = aCustomer.lastname;
        customer.passwordHash = aCustomer.password_hash;
        customer.vatNumber = aCustomer.taxvat;

        [items addObject:customer];
    }
    return items;
}



@end
