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

#import "complexFilter.h" 


@implementation complexFilter

-(id)initWithArray:(NSArray*)array {
    self = [super init];
    if (self) {
        @try {
            for (int i0 = 0; i0 < [array count]; i0++)
            {
                if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"key"]==NSOrderedSame)){
                    NSString* nodeContentValue = [[NSString alloc] initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    if (nodeContentValue !=nil)
                        [self setKey:nodeContentValue];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeChildArray"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"value"]==NSOrderedSame)){
                    NSArray* arrayXml = [[array  objectAtIndex:i0] objectForKey:@"nodeChildArray"];
                    associativeEntity* nodeContentValue = [[associativeEntity alloc] initWithArray:arrayXml];
                    [self setValue:nodeContentValue];
                }
            }
        }
        @catch(NSException *ex){
        }
    }
    return self;
}
-(NSString*)toString:(BOOL)addNameWrap {
    NSMutableString *nsString = [NSMutableString string];
    if (addNameWrap == YES)
        [nsString appendString:@"<complexFilter>" ];
    if (self.key != nil) {
        [nsString appendFormat:@"<key>%@</key>" , [self key]];
    }
    if (self.value != nil) {
        [nsString appendFormat:@"<value>%@</value>" , [self.value toString:NO]];
    }
    if (addNameWrap == YES)
        [nsString appendString:@"</complexFilter>" ];
    return nsString;
}
#pragma mark - NSCoding
-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self){
        self.key = [decoder decodeObjectForKey:@"key"];
        self.value = [decoder decodeObjectForKey:@"value"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.key forKey:@"key"];
    [encoder encodeObject:self.value forKey:@"value"];
}
-(id)copyWithZone:(NSZone *)zone {
    complexFilter *finalCopy = [[[self class] allocWithZone: zone] init];
    
    NSString *copy1 = [self.key copy];
    finalCopy.key = copy1;
    
    associativeEntity *copy2 = [self.value copy];
    finalCopy.value = copy2;
    
    return finalCopy;
}

@end
