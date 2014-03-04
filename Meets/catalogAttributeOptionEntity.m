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

#import "catalogAttributeOptionEntity.h" 


@implementation catalogAttributeOptionEntity

-(id)initWithArray:(NSArray*)array {
    self = [super init];
    if (self) {
        @try {
            for (int i0 = 0; i0 < [array count]; i0++)
            {
                if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"label"]==NSOrderedSame)){
                    NSString* nodeContentValue = [[NSString alloc] initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    if (nodeContentValue !=nil)
                        [self setLabel:nodeContentValue];
                }
                else if ( ([[array objectAtIndex:i0] objectForKey:@"nodeContent"] !=nil) &&  ([[[array objectAtIndex:i0]objectForKey:@"nodeName"]caseInsensitiveCompare:@"value"]==NSOrderedSame)){
                    NSString* nodeContentValue = [[NSString alloc] initWithString:[[array objectAtIndex:i0] objectForKey:@"nodeContent"]];
                    if (nodeContentValue !=nil)
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
        [nsString appendString:@"<catalogAttributeOptionEntity>" ];
    if (self.label != nil) {
        [nsString appendFormat:@"<label>%@</label>" , [self label]];
    }
    if (self.value != nil) {
        [nsString appendFormat:@"<value>%@</value>" , [self value]];
    }
    if (addNameWrap == YES)
        [nsString appendString:@"</catalogAttributeOptionEntity>" ];
    return nsString;
}
#pragma mark - NSCoding
-(id)initWithCoder:(NSCoder *)decoder{
    self = [super init];
    if (self){
        self.label = [decoder decodeObjectForKey:@"label"];
        self.value = [decoder decodeObjectForKey:@"value"];
    }
    return self;
}
-(void)encodeWithCoder:(NSCoder *)encoder{
    [encoder encodeObject:self.label forKey:@"label"];
    [encoder encodeObject:self.value forKey:@"value"];
}
-(id)copyWithZone:(NSZone *)zone {
    catalogAttributeOptionEntity *finalCopy = [[[self class] allocWithZone: zone] init];
    
    NSString *copy1 = [self.label copy];
    finalCopy.label = copy1;
    
    NSString *copy2 = [self.value copy];
    finalCopy.value = copy2;
    
    return finalCopy;
}

@end
