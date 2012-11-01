//
//  ParseCellDataArray.m
//  TableView
//
//  Created by Admin on 10/31/12.
//
//

#import "ParseCellDataArray.h"
#import "CellDataArray.h"
#import "GDataXMLNode.h"
#import "CellData.h"

@implementation ParseCellDataArray

+ (NSString *)dataFilePath:(BOOL)forSave {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory
                               stringByAppendingPathComponent:@"CellDataArray.xml"];
    if (forSave ||
        [[NSFileManager defaultManager] fileExistsAtPath:documentsPath]) {
        return documentsPath;
    } else {
        return [[NSBundle mainBundle] pathForResource:@"CellDataArray" ofType:@"xml"];
    }
    
}

+ (void)loadCellDataArray {
    
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
        [CellDataArray addInArrayCellData:cellData];
        [cellData release];
        
    }
    
    [doc release];
    [xmlData release];
}
+ (void)saveCellDataArray {
    
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
        
        [cellDataElement addChild:strVarElement];
        [cellDataElement addChild:boolVarElement];
        [cellDataElement addChild:choiseVarElement];
        [cellDataArrayElement addChild:cellDataElement];
    }
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:cellDataArrayElement];
    NSData *xmlData = document.XMLData;
    
    NSString *filePath = [self dataFilePath:TRUE];
    [xmlData writeToFile:filePath atomically:YES];
    [document release];
    
}

@end