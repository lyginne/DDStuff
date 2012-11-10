//
//  ParseCellDataArray.m
//  TableView
//
//  Created by Admin on 10/31/12.
//
//
#import <Foundation/Foundation.h>
#import "OperationsWithDataSource.h"
#import "CellDataArray.h"
#import "GDataXMLNode.h"
#import "CellData.h"
#import "DefaultParserDelegate.h"
#import <sqlite3.h>

@interface OperationsWithDataSource (Loaders)

+(void)loadCellDataArrayDOM;
+(void)loadCellDataArrayDefault;
+(void)loadCellDataArraySQLITE;

@end

@interface OperationsWithDataSource (Savers)

+(void)saveCellDataArrayDOM;
+(void)saveCellDataArrayDefault;
//+(void)saveCellDataArraySQLite;

@end

@implementation OperationsWithDataSource

+ (NSString *)dataFilePath:(BOOL)forSave {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:@"CellDataArray.xml"];
    if (forSave || [[NSFileManager defaultManager] fileExistsAtPath:documentsPath])
        return documentsPath;
    else
        return [[NSBundle mainBundle] pathForResource:@"CellDataArray" ofType:@"xml"];
}

+ (void)loadData {
    
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"data_source"]) {
        case 0:
            //SQL
            [OperationsWithDataSource loadCellDataArraySQLITE];
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

+ (void)saveData {
    
    switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"data_source"]) {
        case 0:
            //SQL
            break;
            
        case 1:
            [OperationsWithDataSource saveCellDataArrayDefault];
            break;
            
        case 2:
            //parseDOM
            [OperationsWithDataSource saveCellDataArrayDOM];
    }
    
}

// -----------------------------Loaders------------------

+(void)loadCellDataArrayDOM{
    
    NSString *filePath = [self dataFilePath:FALSE];
    NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:filePath];
    NSError *error;
    GDataXMLDocument *doc = [[GDataXMLDocument alloc] initWithData:xmlData
                                                           options:0
                                                             error:&error];
    NSArray *cellDataElements = [doc.rootElement elementsForName:@"CellData"];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    for (GDataXMLElement *cellDataElement in cellDataElements)
    {
        CellData *cellData = [[CellData alloc] init];
        [cellData setStringVar:[[[cellDataElement  elementsForName:@"strVar"] objectAtIndex:0] stringValue]];
        [cellData setBoolVar:[[[[cellDataElement elementsForName:@"boolVar"] objectAtIndex:0] stringValue] boolValue]];
        [cellData setChoiseVar:[[[[cellDataElement elementsForName:@"choiseVar"] objectAtIndex:0] stringValue] integerValue]];     
        [cellData setDate:[dateFormat dateFromString:[[[cellDataElement elementsForName:@"date"] objectAtIndex:0] stringValue]]];
        [CellDataArray addInArrayCellData:cellData];
        [cellData release];
    }
    [dateFormat release];
    [doc release];
    [xmlData release];
}

+(void) loadCellDataArrayDefault{
    
    NSString *filepath = [self dataFilePath:FALSE];    
    NSData *data = [NSData dataWithContentsOfFile:filepath];
    NSXMLParser *nsXmlParser = [[NSXMLParser alloc] initWithData:data];
    DefaultParserDelegate *parser = [[DefaultParserDelegate alloc]init];
    [nsXmlParser setDelegate:parser];
    
    [nsXmlParser parse];
    
    [parser release];
    [nsXmlParser release];
}

+(void) loadCellDataArraySQLITE
{
    
    sqlite3 *db;
    
    
    @try {
        NSFileManager *fileMGR = [NSFileManager defaultManager];
        NSString *filepath = @"/Users/mac/Desktop/CellDataArray.sqlite";
        
        BOOL success = [fileMGR fileExistsAtPath:filepath];
        
        if (!success)
        {
            NSLog(@"Cannot delocate file %@", filepath);
        }
        
        if ((!sqlite3_open([filepath UTF8String], &db) == SQLITE_OK))
        {
            NSLog(@"ERROR HERE! %s,", sqlite3_errmsg(db));
        }
        
        
        
        const char *sql = "SELECT * FROM CellDataArraySQLITE";
        sqlite3_stmt *sqlStatement;
        
        if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL)!= SQLITE_OK)
        {
            NSLog(@"PRoblem with statement %s", sqlite3_errmsg(db));
            
        }
        
        
        
        else
        {
            while (sqlite3_step(sqlStatement) == SQLITE_ROW)
            {
                CellData *cell = [[CellData alloc] init];
                cell.stringVar = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)];
                cell.boolVar = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)]boolValue];
                cell.choiseVar =  [[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)]intValue];
                
                NSString *str = [NSString stringWithString:[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)]];
                NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
                [dateFormat setDateFormat:@"YYYY-MM-dd"];
                
                NSDate *date = [dateFormat dateFromString:str];
                cell.date = date;
                [dateFormat release];
                
                
                
                
                
                const char *raw = sqlite3_column_blob(sqlStatement, 4);
                int rawLen = sqlite3_column_bytes(sqlStatement, 4);
                NSData *data = [NSData dataWithBytes:raw length:rawLen];
                cell.image = [[UIImage alloc] initWithData:data];
                
                
                [CellDataArray addInArrayCellData:cell];
                [cell release];
                
            }
            
            
            
            
            
            
            
            
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Problem with prepare statement %s", sqlite3_errmsg(db));
    }
    @finally {
        sqlite3_close(db);
    }
    
    
    
    
    
}
// -----------------------------Savers------------------

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
        [dateFormat release];
    }
    
    GDataXMLDocument *document = [[GDataXMLDocument alloc] initWithRootElement:cellDataArrayElement];
    NSData *xmlData = document.XMLData;
    
    NSString *filePath = [self dataFilePath:TRUE];
    [xmlData writeToFile:filePath atomically:YES];
    [document release];
}

+(void) saveCellDataArrayDefault{
    
    NSString *filepath = [self dataFilePath:TRUE];
    NSMutableString *myXML = [[NSMutableString alloc] init];
    [myXML appendString:@"<CellDataArray>"];
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    for (CellData *cellData in [CellDataArray getArray])
        [myXML appendString:[NSString stringWithFormat:@"<CellData>\n<strVar>%@</strVar>\n<boolVar>%@</boolVar>\n<choiseVar>%d</choiseVar>\n<date>%@</date>\n</CellData>\n", cellData.stringVar, cellData.boolVar?@"YES":@"NO", cellData.choiseVar,[dateFormat stringFromDate:[cellData date]]]]; //заплить большую строку с кучей всех данных из CellDataArrray
    
    [myXML appendString:@"</CellDataArray>"];
    [myXML writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    [myXML release];
    [dateFormat release];
}
@end