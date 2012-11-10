//
//  DefaultParserDelegate.m
//  TableView
//
//  Created by Mac on 07.11.12.
//
//
#import <Foundation/Foundation.h>
#import "DefaultParserDelegate.h"
#import "CellDataArray.h"
#import "CellData.h"

@implementation DefaultParserDelegate {
    
    NSString *_bufferString;
    CellData *cell;
}

-(void) parser: (NSXMLParser*) parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"CellData"])        
        cell = [[CellData alloc] init];
}

-(void) parser: (NSXMLParser *)parser
foundCharacters:(NSString *)string{
    
    [_bufferString release];
    _bufferString=[string copy];
}

-(void) parser:(NSXMLParser *) paser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{    
    
    if ([elementName isEqualToString:@"strVar"])
        cell.stringVar=_bufferString;
    if ([elementName isEqualToString:@"boolVar"])
        cell.boolVar = [_bufferString boolValue];
    if ([elementName isEqualToString:@"choiseVar"])
        cell.choiseVar = [_bufferString intValue];
    if ([elementName isEqualToString:@"date" ])
    {
        NSString *str = [NSString stringWithString: _bufferString];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"YYYY-MM-dd"];
        cell.date = [dateFormat dateFromString:str];
        [dateFormat release];
    }
    if ([elementName isEqualToString:@"CellData"])
    {
        [CellDataArray addInArrayCellData:cell];
        [cell release];
        cell = nil;
    }
    
    [_bufferString release];
    _bufferString=nil;
}
@end