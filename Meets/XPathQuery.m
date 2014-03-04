//
//  XPathQuery.m
//  FuelFinder
//
//  Created by Matt Gallagher on 4/08/08.
//  Copyright 2008 __MyCompanyName__. All rights reserved.
//

#import "XPathQuery.h"


@implementation XPathQuery


-(NSDictionary *)newDictionaryForNode:(xmlNodePtr) currentNode andParentResult:(NSMutableDictionary *)parentResult
{
	NSMutableDictionary *resultForNode = [[NSMutableDictionary alloc] init];
	
	if (currentNode->name)
	{
		NSString *currentNodeContent = [[NSString alloc] initWithCString:(const char *)currentNode->name encoding:NSUTF8StringEncoding];
		[resultForNode setObject:currentNodeContent forKey:@"nodeName"];
	}
	
	if (currentNode->content && currentNode->content != (xmlChar *)-1)
	{
		NSString *currentNodeContent = [[NSString alloc] initWithCString:(const char *)currentNode->content encoding:NSUTF8StringEncoding];
		
		if ([[resultForNode objectForKey:@"nodeName"] isEqual:@"text"] && parentResult)
		{
			[parentResult
			 setObject:[currentNodeContent stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]
			 forKey:@"nodeContent"];

			return nil;
		}
		
		[resultForNode setObject:currentNodeContent forKey:@"nodeContent"];
    }
	
	xmlAttr *_attribute = currentNode->properties;
	if (_attribute)
    {
		NSMutableArray *attributeArray = [[NSMutableArray alloc] init];
		while (_attribute)
        {
			NSMutableDictionary *attributeDictionary = [[NSMutableDictionary alloc] init];
			NSString *attributeName = [[NSString alloc] initWithCString:(const char *)_attribute->name encoding:NSUTF8StringEncoding];
			if (attributeName)
				[attributeDictionary setObject:attributeName forKey:@"attributeName"];
			
			if (_attribute->children)
            {
				NSDictionary *childDictionary = [self newDictionaryForNode:(_attribute->children) andParentResult:attributeDictionary];
				
				// NSDictionary *childDictionary = DictionaryForNode(_attribute->children, attributeDictionary);
				if (childDictionary)
                {
					[attributeDictionary setObject:childDictionary forKey:@"attributeContent"];
                }
            }
			
			if ([attributeDictionary count] > 0)
            {
				[attributeArray addObject:attributeDictionary];
            }
			_attribute = _attribute->next;

        }
		
		if ([attributeArray count] > 0)
        {
			[resultForNode setObject:attributeArray forKey:@"nodeAttributeArray"];
        }
	}
	
	xmlNodePtr childNode = currentNode->children;
	if (childNode)
    {
		NSMutableArray *childContentArray = [[NSMutableArray alloc] init];
		while (childNode)
        {
			NSDictionary *childDictionary = [self newDictionaryForNode:childNode andParentResult:resultForNode];
			
			if (childDictionary)
            {
				[childContentArray addObject:childDictionary];
            }
			childNode = childNode->next;
			
        }
		
		if ([childContentArray count] > 0)
        {
			[resultForNode setObject:childContentArray forKey:@"nodeChildArray"];
        }
    }
	
	return resultForNode;
}

-(NSArray *)newXPathQueryArrayResult:(xmlDocPtr)doc andQuery:(NSString *)query
{
	xmlXPathContextPtr xpathCtx;
	xmlXPathObjectPtr xpathObj;
	
	/* Create xpath evaluation context */
  	xpathCtx = xmlXPathNewContext(doc);
	
	if(xpathCtx == NULL)
    {
		//debug(@"Unable to create XPath context.", nil);
		return nil;
    }
	//@"xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/'");//Extract data
	
	xmlXPathRegisterNs(xpathCtx, (xmlChar *)[@"xsi" cStringUsingEncoding:NSUTF8StringEncoding],(xmlChar *) [@"http://www.w3.org/2001/XMLSchema-instance" cStringUsingEncoding:NSUTF8StringEncoding]);
	xmlXPathRegisterNs(xpathCtx, (xmlChar *)[@"xsd" cStringUsingEncoding:NSUTF8StringEncoding], (xmlChar *)[@"http://www.w3.org/2001/XMLSchema"cStringUsingEncoding:NSUTF8StringEncoding]);
	xmlXPathRegisterNs(xpathCtx, (xmlChar *)[@"soap" cStringUsingEncoding:NSUTF8StringEncoding], (xmlChar *)[@"http://schemas.xmlsoap.org/soap/envelope/"cStringUsingEncoding:NSUTF8StringEncoding]);
	
	
	/* Evaluate xpath expression */
	xpathObj = xmlXPathEvalExpression((xmlChar *)[query cStringUsingEncoding:NSUTF8StringEncoding], xpathCtx);
	if(xpathObj == NULL) {
		return nil;
	}
	
	xmlNodeSetPtr nodes = xpathObj->nodesetval;
	if (!nodes)
    {
		return nil;
    }
	
	NSMutableArray *resultNodes = [[NSMutableArray alloc] init];
	for (NSInteger i = 0; i < nodes->nodeNr; i++)
    {
		NSDictionary *nodeDictionary = [self newDictionaryForNode:nodes->nodeTab[i] andParentResult:nil];
		
		if (nodeDictionary)
			[resultNodes addObject:nodeDictionary];
		
    }
	
	/* Cleanup */
	xmlXPathFreeObject(xpathObj);
	xmlXPathFreeContext(xpathCtx);
	
	return resultNodes;
}

-(NSArray *)newXMLXPathQueryResult:(NSData *)document andQuery:(NSString *)query
{
	xmlDocPtr doc = xmlReadMemory([document bytes], [document length], "", NULL, XML_PARSE_RECOVER);
	
	if (doc == NULL)
    {
		return nil;
    }
	
	NSArray *result = [self newXPathQueryArrayResult:doc andQuery:query];
	xmlFreeDoc(doc);
	
	return result;
}

@end
