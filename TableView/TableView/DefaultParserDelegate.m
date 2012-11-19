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
#import "NSData+Base64.h"

@implementation DefaultParserDelegate {
    
    NSMutableString *_bufferString;
    CellData *cell;
}

-(void) parser: (NSXMLParser*) parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict{
    
    if ([elementName isEqualToString:@"CellData"])        
        cell = [[CellData alloc] init];
    [_bufferString release];
    _bufferString=nil;
}

-(void) parser: (NSXMLParser *)parser
foundCharacters:(NSString *)string{
    
    if(!_bufferString)
        _bufferString=[[NSMutableString alloc] init];
    [_bufferString appendString:string];
}

-(void) parser:(NSXMLParser *) paser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName{    
    
    if ([elementName isEqualToString:@"strVar"])
    {
        if([_bufferString isEqualToString:@"(null)"]) {
           cell.stringVar=nil; 
        }
        else {
            cell.stringVar=_bufferString;
        }
    }
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
    if ([elementName isEqualToString:@"img"])
    {
        NSData *data=[NSData dataFromBase64String:_bufferString];
        cell.image=[UIImage imageWithData:data];
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