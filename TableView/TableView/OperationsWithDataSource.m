//
//  ParseCellDataArray.m
//  TableView
//
//  Created by Admin on 10/31/12.
//
//

#import "OperationsWithDataSource.h"
#import "CellDataArray.h"
#import "GDataXMLNode.h"
#import "CellData.h"
#import "DefaultParserDelegate.h"

@implementation OperationsWithDataSource

+(void)loadCellDataArrayDOM{
    
    NSLog(@"%d",[[NSUserDefaults standardUserDefaults] integerForKey:@"data_source"]);
    NSString *filePath = [self dataFilePath:FALSE];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                           options:0 error:&error];
    
    NSArray *cellDataElements = [doc.rootElement elementsForName:@"CellData"];
    
    for (GDataXMLElement *cellDataElement in cellDataElements) {
        CellData *cellData = [[CellData alloc] init];
        [cellData setStringVar:[[[cellDataElement  elementsForName:@"strVar"] objectAtIndex:0] stringValue]];
        [cellData setBoolVar:[[[[cellDataElement elementsForName:@"boolVar"] objectAtIndex:0] stringValue] boolValue]];
        [cellData setChoiseVar:[[[[cellDataElement elementsForName:@"choiseVar"] objectAtIndex:0] stringValue] integerValue]];
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        //[dateFormat dateFromString:[[[cellDataElement elementsForName:@"date"] objectAtIndex:0] stringValue]];
        [cellData setDate:[dateFormat dateFromString:[[[cellDataElement elementsForName:@"date"] objectAtIndex:0] stringValue]]];
        [CellDataArray addInArrayCellData:cellData];
        [cellData release];
        
    }
    
    [doc release];
    [xmlData release];
}

+ (NSString *)dataFilePath:(BOOL)forSave {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:@"CellDataArray.xml"];
    if (forSave ||
       [[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
        return documentsPath;
    } else {
        return [[NSBundle mainBundle] pathForResource:@"CellDataArray" ofType:@"xml"];
    }
    
}

+ (void)loadData {
    
    
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"data_source"]) {
        case 0:
            //SQL
            break;
            
        case 1:
            //parseDefault
            [OperationsWithDataSource loadCellDataArrayDefault];
            break;
            
        case 2:
            //parseDOM
            [OperationsWithDataSource loadCellDataArrayDOM];
    }    
}
+(void) saveCellDataArrayDOM {
    GDataXMLElement * cellDataArrayElement = [GDataXMLNode elementWithName:@"CellDataArray"];
    
    for(CellData *cellData in [CellDataArray getArray]) {
        
        GDataXMLElement * cellDataElement =
        [GDataXMLNode elementWithName:@"CellData"];
        GDataXMLElement * strVarElement =
        [GDataXMLNode elementWithName:@"strVar"
                          stringValue:[cellData stringVar]];
        GDataXMLElement * boolVarElement =
        [GDataXMLNode elementWithName:@"boolVar"
                          stringValue: [NSString stringWithFormat:@"%@", [cellData boolVar]?@"YES":@"NO"]];
        GDataXMLElement * choiseVarElement =
        [GDataXMLNode elementWithName:@"choiseVar"
                          stringValue:[NSString stringWithFormat:@"%d", [cellData choiseVar]]];
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        GDataXMLElement * dateElement =
        [GDataXMLNode elementWithName:@"date"
                          stringValue:[dateFormat stringFromDate:[cellData date]]];
        
        [cellDataElement addChild:strVarElement];
        [cellDataElement addChild:boolVarElement];
        [cellDataElement addChild:choiseVarElement];
        [cellDataElement addChild:dateElement];
        [cellDataArrayElement addChild:cellDataElement];
    }
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:cellDataArrayElement];
    NSData *xmlData = document.XMLData;
    
    NSString *filePath = [self dataFilePath:TRUE];
    [xmlData writeToFile:filePath atomically:YES];
    [document release];

}
+ (void)saveData {
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"data_source"]) {
        case 0:
            //SQL
            break;
            
        case 1:
            //parseDefault
            break;
            
        case 2:
            //parseDOM
            [OperationsWithDataSource saveCellDataArrayDOM];
    }
    
}



// -----------------------------DefaultParse------------------


+(void) loadCellDataArrayDefault
{
    
    
    
    
    NSString *filepath = [self dataFilePath:FALSE];
    
    // NSString *filepath = @"/Users/mac/Desktop/CellDataArray.xml";
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    DefaultParserDelegate *parser = [[DefaultParserDelegate alloc]initXmlParser];
    [nsXmlParser setDelegate:parser];
    
    
    //parsing..
    
    BOOL succes = [nsXmlParser parse];
    
    if (succes)
    {
        NSLog(@"NO ERRORS - %d cells succesfully parsed", [parser countOfCells]);
    }
    
    else
    {
        NSLog(@"Error parsing document!");
        NSLog(@"Error - %@", parser.error);
    }
    
    
    [parser release];
    [nsXmlParser release];
    

    
    
    
}



+(void) saveCellDataArrayDefault
{
    
}




















@end