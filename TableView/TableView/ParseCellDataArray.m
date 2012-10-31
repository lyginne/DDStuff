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
    
    //Party *party = [[[Party alloc] init] autorelease];
    NSArray *cellDataElements = [doc.rootElement elementsForName:@"CellData"];
    
    for (GDataXMLElement *partyMember in cellDataElements) {
        CellData *cellData = [[CellData alloc] init];
        [cellData setStringVar:[[[partyMember  elementsForName:@"strVar"] objectAtIndex:0] stringValue]];
        [cellData setBoolVar:[[[[partyMember elementsForName:@"boolVar"] objectAtIndex:0] stringValue] boolValue]];
        [cellData setChoiseVar:[[[[partyMember elementsForName:@"choiseVar"] objectAtIndex:0] stringValue] integerValue]];
         [CellDataArray addInArrayCellData:cellData];
        [cellData release];
        
    }
    
    [doc release];
    [xmlData release];
}
+ (void)saveCellDataArray {
    
    GDataXMLElement * cellDataArrayElement = [GDataXMLNode elementWithName:@"CellDataArray"];
    
    for(CellData *cellData in [CellDataArray getArray]) {
        
        GDataXMLElement * playerElement =
        [GDataXMLNode elementWithName:@"CellData"];
        GDataXMLElement * nameElement =
        [GDataXMLNode elementWithName:@"strVar" stringValue:[cellData stringVar]];
        GDataXMLElement * levelElement =
        [GDataXMLNode elementWithName:@"boolVar" stringValue:
         [NSString stringWithFormat:@"%@", [cellData boolVar]?@"YES":@"NO"]];

        GDataXMLElement * classElement =
        [GDataXMLNode elementWithName:@"choiseVar" stringValue:[NSString stringWithFormat:@"%d", [cellData choiseVar]]];
        
        [playerElement addChild:nameElement];
        [playerElement addChild:levelElement];
        [playerElement addChild:classElement];
        [cellDataArrayElement addChild:playerElement];
    }
    
    GDataXMLDocument *document = [[[GDataXMLDocument alloc]
                                   initWithRootElement:cellDataArrayElement] autorelease];
    NSData *xmlData = document.XMLData;
    
    NSString *filePath = [self dataFilePath:TRUE];
    NSLog(@"Saving xml data to %@...", filePath);
    [xmlData writeToFile:filePath atomically:YES];
    
}

@end