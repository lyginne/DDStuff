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

@implementation DefaultParserDelegate


@synthesize cell;
@synthesize tag;
@synthesize error=m_error;

-(DefaultParserDelegate *) initXmlParser
{
    [super init];
    
    
    // create NSMUT
    
    return self;
}

-(NSUInteger) countOfCells
{
    return [CellDataArray countOfArray];
}



// если произошла ошибка парсинга
-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {

    m_error = [parseError retain];
    return;
}

-(void) parser: (NSXMLParser*) parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"CellData"])
        
    {
        cell = [[CellData alloc] init];
    }
    
    
    if ([elementName isEqualToString:@"strVar"])
    {
        NSLog(@"tag creating for strVar");
        
        tag = [[NSString alloc] init];
        tag = @"strVar";
    }
    
    if ([elementName isEqualToString:@"boolVar"])
    {
        NSLog(@"tag creating for boolVar");
        
        tag = [[NSString alloc] init];
        tag = @"boolVar";
    }
    
    if ([elementName isEqualToString:@"choiseVar"])
    {
        NSLog(@"tag creating for choiseVar");
        
        tag = [[NSString alloc] init];
        tag = @"choiseVar";
    }
    
    if ([elementName isEqualToString:@"date"])
    {
        NSLog(@"tag creating for date");
        
        tag = [[NSString alloc] init];
        tag = @"date";
    }

    
    
    
    
    
}





-(void) parser: (NSXMLParser *)parser foundCharacters:(NSString *)string
{
    
    if (!currentElementValue)
    {
        currentElementValue = [[NSMutableString alloc] init];
    }
      else
      {
          [currentElementValue appendString:string];
          
             if (tag == @"strVar")
             {
                 cell.stringVar = currentElementValue;
             }
          
             if (tag == @"boolVar")
             {
                 
                 bool b = [currentElementValue boolValue];
                 cell.boolVar = b;
                 
             }
          
             if (tag == @"choiseVar")
             {
                 int a = [currentElementValue intValue];
                 cell.choiseVar = a;
                 
             }
          
             if (tag == @"date")
             {
               
                 NSString *str = [[NSString alloc] init];
                 str = currentElementValue;
                 NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                 [dateFormat setDateFormat:@"YYYY-MM-dd"];
                 
               NSDate *date = [dateFormat dateFromString:str];
                 cell.date = date;
                 
                 
                 
             }







      }

        
        

    
    
    
    
}




-(void) parser:(NSXMLParser *) paser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName

{
    if ([elementName isEqualToString:@"cellDataXML"])
    {
        // reached an end of document
        return;
    }
    
    if ([elementName isEqualToString:@"CellData"])
    {
        // reached an end of current cell data
        
        NSLog(@"Succeed! So, the stringVar is -  %@ , \n , the boolVar is - %i, \n , the choiseVar is - %d, \n, the date is - %@ ! ", cell.stringVar, cell.boolVar, cell.choiseVar, cell.date);
        
        [CellDataArray addInArrayCellData:cell];
        [cell release];
        [tag release];
        cell = nil;
    }
    
    [currentElementValue release];
    currentElementValue = nil;
    
    
    
    
    
}












@end
