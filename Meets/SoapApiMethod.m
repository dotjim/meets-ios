//
//  SoapApiMethod.m
//  iOS Meets SDK
//
//  Created by Juan Fernández Sagasti on 25/10/13.
//  Original work Copyright (c) 2013 TheAgileMonkeys.
//

#import "SoapApiMethod.h"
#import "MGLogin.h"

@implementation SoapApiMethod


- (void)runWithParams:(NSDictionary *)paramsDictionary
              filters:(filters *)filters
           completion:(RequestCompletion)completion
{
    NSMutableDictionary *fullParams = [NSMutableDictionary dictionary];
    [fullParams addEntriesFromDictionary:paramsDictionary];
    
    if (filters)
        [fullParams addEntriesFromDictionary:@{@"filters": [filters toString:NO]}];
    
    [self runMethod:self.methodName withParams:fullParams completion:completion];
}


- (void)runWithModels:(NSArray *)arrayOfModels
           completion:(RequestCompletion)completion
{
    NSString *serializedModel = [self serializeModels:arrayOfModels];
    [self runMethod:self.methodName withParams:serializedModel completion:completion];
}


- (void)runMethod:(NSString *)method
       withParams:(id)paramsObject
       completion:(RequestCompletion)completion
{
    MeetsSoapSessionManager *manager = [MeetsSoapSessionManager sharedManager];

    AFHTTPRequestOperation *soapOperation;
    NSMutableURLRequest *soapRequest;
    
    if (manager.apiSessionID)
    {
        BOOL serializedParams = ([paramsObject isKindOfClass:[NSString class]]) ? YES : NO;
        soapRequest = [self requestWithMethod:@"POST" path:self.methodName parameters:paramsObject parametersAlreadySerialized:serializedParams];
        
        soapOperation = [manager HTTPRequestOperationWithRequest:soapRequest success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            id response = [self getModelFromResponse:operation.responseString];
            
            // NSLog(@"RESPONSE = %@", operation.responseString);
            if (![response isKindOfClass:[NSError class]])
                completion(response, nil);
            else
            {
                NSError *error = response;
                if (error.code == 5) // Session expired, so renew it and tries again:
                {
                    manager.apiSessionID = nil;
                    [self runMethod:method withParams:paramsObject completion:completion];
                }
                else
                    completion(nil, error);
            }
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            completion(nil, error);
        }];
    }
    else
    {
        NSDictionary *loginParams = @{@"username": manager.soapApiUser, @"apiKey": manager.soapApiPassword};
        soapRequest = [self requestWithMethod:@"POST" path:@"login" parameters:loginParams parametersAlreadySerialized:NO];

        soapOperation = [manager HTTPRequestOperationWithRequest:soapRequest success:^(AFHTTPRequestOperation *operation, id responseObject)
        {
            id response = [self parseLoginResponseFromXmlString:operation.responseString];
            if (response)
            {
                manager.apiSessionID = (NSString *)response;
                [self runWithParams:paramsObject filters:nil completion:completion];
            }
            else
                completion(nil, [self emptyResponseError]);
        }
        failure:^(AFHTTPRequestOperation *operation, NSError *error)
        {
            completion(nil, error);
        }];
    }
    
    [manager.operationQueue addOperation:soapOperation];
}


- (NSError *)emptyResponseError
{
    return [NSError errorWithDomain:@"" code:0 userInfo:@{NSLocalizedDescriptionKey: @"Response is nil"}];
}


- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
									  path:(NSString *)path
								parameters:(id)parameters
               parametersAlreadySerialized:(BOOL)parametersAlreadySerialized
{
    NSMutableString *params = [NSMutableString string];
    [params appendString:@"<?xml version=\"1.0\" encoding=\"utf-8\"?><soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body>"];
    [params appendFormat:@"<%@ xmlns=\"urn:Magento\">", path];
    [params appendFormat:@"<sessionId>%@</sessionId>", [[MeetsSoapSessionManager sharedManager] apiSessionID]];
    
    MeetsSoapSessionManager *manager = [MeetsSoapSessionManager sharedManager];
    [params appendFormat:@"<store>%@</store>", manager.storeId];
    [params appendFormat:@"<storeId>%@</storeId>", manager.storeId];
    [params appendFormat:@"<storeView>%@</storeView>", manager.storeId];

    if (parametersAlreadySerialized)
        [params appendString:parameters];
    else
        [params appendString:[self serializeParamsDictionary:parameters]];

    [params appendFormat:@"</%@>", path];
    [params appendString:@"</soap:Body></soap:Envelope>"];
    
    // NSLog(@"ENVELOPE = %@", params);
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:manager.baseURL.absoluteString]];
    NSString *messageLen = [NSString stringWithFormat:@"%lu", (unsigned long)[params length]];
    [request addValue:[NSString stringWithFormat:@"urn:Magento/%@", path] forHTTPHeaderField:@"SOAPAction"];
    [request addValue:@"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:messageLen forHTTPHeaderField:@"Content-Length"];
    [request setHTTPMethod:method];
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    
    if (manager.basicAuthUser && manager.basicAuthPassword)
    {
        NSData *plainData = [[NSString stringWithFormat:@"%@:%@", manager.basicAuthUser, manager.basicAuthPassword] dataUsingEncoding:NSUTF8StringEncoding];
        NSString *base64String = [plainData base64EncodedStringWithOptions:0];
        [request addValue:[NSString stringWithFormat:@"Basic %@", base64String] forHTTPHeaderField:@"Authorization"];
    }
    
    return request;
}


- (NSString *)parseLoginResponseFromXmlString:(NSString *)xml
{
    NSString *xmldata = [xml stringByReplacingOccurrencesOfString:@"xmlns=\"urn:Magento\"" withString:@""];
    NSData *data = [xmldata dataUsingEncoding:NSUTF8StringEncoding];
    XPathQuery *xpathQuery = [[XPathQuery alloc] init];
    NSString * query = [NSString stringWithFormat:@"/soap:Envelope/soap:Body/*/*"];
    NSArray *arrayOfWSData = [xpathQuery newXMLXPathQueryResult:data andQuery:query];
    NSString* result = nil;
    if([arrayOfWSData count] > 0 )
    {
        NSString *nodeContentValue = [[NSString alloc] initWithString:[[arrayOfWSData objectAtIndex:0] objectForKey:@"nodeContent"]];
        if (nodeContentValue !=nil){
            result = [[NSString alloc] initWithString:nodeContentValue];
        }
    }
    return result;
}

- (id)getModelFromResponse:(id)responseObject
{
    id output = [self getErrorFromResponse:responseObject]; // Check for SOAP faults.

    if (!output)
    {
        output = [self parseResponseFromXmlString:responseObject];
        output = (output) ? [self mapResponseToModelObjectWithResponse:output] : nil;
        if (!output)
            output = [self emptyResponseError];
    }
    
    return output; // Returns a NSError or a Model Object
}


- (NSError *)getErrorFromResponse:(id)responseObject
{
    NSError *error = nil;
    
    if (([responseObject rangeOfString:@"faultcode"].location != NSNotFound) && ([responseObject rangeOfString:@"faultstring"].location != NSNotFound))
    {
        NSRange r1 = [responseObject rangeOfString:@"<faultcode>"];
        NSRange r2 = [responseObject rangeOfString:@"</faultcode>"];
        NSRange rSub = NSMakeRange(r1.location + r1.length, r2.location - r1.location - r1.length);
        NSString *errorCode = [responseObject substringWithRange:rSub];
        
        r1 = [responseObject rangeOfString:@"<faultstring>"];
        r2 = [responseObject rangeOfString:@"</faultstring>"];
        rSub = NSMakeRange(r1.location + r1.length, r2.location - r1.location - r1.length);
        NSString *errorDescription = [responseObject substringWithRange:rSub];
        
        error = [NSError errorWithDomain:@"Magento" code:errorCode.integerValue userInfo:@{NSLocalizedDescriptionKey: errorDescription}];
    }

    return error;
}


- (NSString *)serializeParamsDictionary:(NSDictionary *)parameters
{
    NSMutableString *outputString = [[NSMutableString alloc] initWithString:@""];
    
    for (NSString *key in parameters)
    {
        id value = parameters[key];
        if (value)
        {
            [outputString appendFormat:@"<%@>", key];

            if ([value isKindOfClass:[NSDictionary class]])
                [outputString appendString:[self serializeParamsDictionary:value]];
            else if ([value isKindOfClass:[NSArray class]])
                [outputString appendString:[self serializeParamsArray:value]];
            else
                [outputString appendFormat:@"%@", value];
            
            [outputString appendFormat:@"</%@>", key];
        }
        else
            [outputString appendFormat: @"<%@ xsi:nil=\"true\"/>", key];

    }
    
    return outputString;
}


- (NSString *)serializeParamsArray:(NSArray *)parameters
{
    NSMutableString *outputString = [[NSMutableString alloc] initWithString:@""];

    for (id object in parameters)
    {
        if ([object isKindOfClass:[NSDictionary class]])
            [outputString appendString:[self serializeParamsDictionary:object]];
        else
            [outputString appendFormat:@"<item>%@</item>", object];
    }
    
    return outputString;
}


- (NSString *)serializeModels:(NSArray *)arrayOfModels
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}


- (id)parseResponseFromXmlString:(NSString *)xml
{
    @throw [Errors overrideException:NSStringFromSelector(_cmd)];
}

@end
