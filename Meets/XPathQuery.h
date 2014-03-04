//
//  XPathQuery.h
//  FuelFinder
//
//  Created by Matt Gallagher on 4/08/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

//NSArray *newXMLXPathQueryResult(NSData *document, NSString *query);
//NSArray *PerformHTMLXPathQuery(NSData *document, NSString *query);


#import <libxml/tree.h>
#import <libxml/parser.h>
#import <libxml/HTMLparser.h>
#import <libxml/xpath.h>
#import <libxml/xpathInternals.h>
#import <Foundation/Foundation.h>

@interface XPathQuery : NSObject
{
    
}

-(NSArray *)newXPathQueryArrayResult:(xmlDocPtr)doc andQuery:(NSString *)query;
-(NSDictionary *)newDictionaryForNode:(xmlNodePtr) currentNode andParentResult:(NSMutableDictionary *)parentResult;

-(NSArray *)newXMLXPathQueryResult:(NSData *)document andQuery:(NSString *)query;
@end








