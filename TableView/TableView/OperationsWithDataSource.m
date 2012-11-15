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
#import "NSData+Base64.h"

@interface OperationsWithDataSource (Loaders)

+(void)loadCellDataArrayDOM;
+(void)loadCellDataArrayDefault;
+(void)loadCellDataArraySQLITE;

@end

@interface OperationsWithDataSource (Savers)

+(void)saveCellDataArrayDOM;
+(void)saveCellDataArrayDefault;
+(void)saveCellDataArraySQLITE;

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

+(NSString *) dataFilePathSQLITE:(BOOL)forSave
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *documentsPath = [documentsDirectory stringByAppendingPathComponent:@"CellData.sqlite"];
//    if (forSave || [[NSFileManager defaultManager] fileExistsAtPath:documentsPath])
//        return documentsPath;
//    else
        return [[NSBundle mainBundle] pathForResource:@"CellDataArray" ofType:@"sqlite"];
}

+ (void)loadData {
    @autoreleasepool {
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
}

+ (void)saveData {
    @autoreleasepool {
        switch ([[NSUserDefaults standardUserDefaults] integerForKey:@"data_source"]) {
            case 0:
                //SQLITE
                [OperationsWithDataSource saveCellDataArraySQLITE];
                break;
            
            case 1:
                [OperationsWithDataSource saveCellDataArrayDefault];
                break;
            
            case 2:
                //parseDOM
                [OperationsWithDataSource saveCellDataArrayDOM];
        }
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
        NSString *imgString=[[[cellDataElement elementsForName:@"img"]objectAtIndex:0]stringValue];
        NSData *data=[NSData dataFromBase64String:imgString];
        cellData.image=[UIImage imageWithData:data];
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
    
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    
    NSString *filepath = [self dataFilePathSQLITE:FALSE];
    
    if ((!sqlite3_open([filepath UTF8String], &db) == SQLITE_OK))
        NSLog(@"ERROR HERE! %s,", sqlite3_errmsg(db));
    
    const char *sql = "SELECT * FROM CellData";
    sqlite3_stmt *sqlStatement;
    
    if(sqlite3_prepare(db, sql, -1, &sqlStatement, NULL)!= SQLITE_OK)
        NSLog(@"PRoblem with statement %s", sqlite3_errmsg(db));
    
    while (sqlite3_step(sqlStatement) == SQLITE_ROW)
    {
        CellData *cell = [[CellData alloc] init];
        cell.stringVar = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 0)];
        cell.boolVar = [[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 1)]boolValue];
        cell.choiseVar =  [[NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 2)]intValue];
                
        NSString *str = [NSString stringWithUTF8String:(char *) sqlite3_column_text(sqlStatement, 3)];         
        NSDate *date = [dateFormat dateFromString:str];
        cell.date = date;
        const char *raw = sqlite3_column_blob(sqlStatement, 4);
        int rawLen = sqlite3_column_bytes(sqlStatement, 4);
        NSData *data = [NSData dataWithBytes:raw length:rawLen];
        cell.image = [[UIImage alloc] initWithData:data];
        [CellDataArray addInArrayCellData:cell];
        [cell release];
                
    }
    [dateFormat release];
    sqlite3_close(db);    
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
        NSData *data = UIImagePNGRepresentation([cellData image]);
        NSString *result=[data base64EncodedString];
        GDataXMLElement *imgElement =
        [GDataXMLNode elementWithName:@"img"
                          stringValue:result];
        
        [cellDataElement addChild:strVarElement];
        [cellDataElement addChild:boolVarElement];
        [cellDataElement addChild:choiseVarElement];
        [cellDataElement addChild:dateElement];
        [cellDataElement addChild:imgElement];
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
    {
        NSData *data = UIImagePNGRepresentation([cellData image]);
        NSString *result=[data base64EncodedString];
        [myXML appendString:[NSString stringWithFormat:@"<CellData>\n<strVar>%@</strVar>\n<boolVar>%@</boolVar>\n<choiseVar>%d</choiseVar>\n<date>%@</date>\n<img>%@</img>\n</CellData>\n", cellData.stringVar, cellData.boolVar?@"YES":@"NO", cellData.choiseVar,[dateFormat stringFromDate:[cellData date]], result]]; //заплить большую строку с кучей всех данных из CellDataArrray
    }
    [myXML appendString:@"</CellDataArray>"];
    [myXML writeToFile:filepath atomically:YES encoding:NSUTF8StringEncoding error:NULL];
    
    [myXML release];
    [dateFormat release];
}



+(void) saveCellDataArraySQLITE

{
    char *err = 0;
    sqlite3 *db = 0;
    const char *dbPath = [[self dataFilePathSQLITE:YES] UTF8String];
    
    if (sqlite3_open(dbPath, &db))
        NSLog(@"DB: open error");
    const char *dropTable="DROP TABLE CellData";
    if (sqlite3_exec(db, dropTable, nil, nil, &err)) {
        NSLog(@"%s", err);
        sqlite3_free(err);
    }
    const char *createTable = "CREATE TABLE CellData (strVar VARCHAR, boolVar VARCHAR, choiseVar INTEGER, date VARCHAR, image BLOB);";
    
    if (sqlite3_exec(db, createTable, nil, nil, &err)) {
        NSLog(@"%s", err);
        sqlite3_free(err);
    }
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    for (CellData *cell in [CellDataArray getArray])
    {
        char *strVar = (char *)[cell.stringVar UTF8String];
        char *dateString = (char *)[[dateFormat stringFromDate:cell.date] UTF8String];
        char *boolVarString = (char *)[cell.boolVar?@"YES":@"NO" UTF8String];
        NSData *image = UIImagePNGRepresentation(cell.image);
    
        const char *insertNewCell = "INSERT INTO CellData VALUES(?, ?, ?, ?, ?)";
        sqlite3_stmt *insertStatement;
        if(sqlite3_prepare_v2(db, insertNewCell, -1, &insertStatement, nil))
            NSLog(@"Add: prepare error");
        if (strVar!=nil)
        {
            sqlite3_bind_text(insertStatement, 1, strVar, strlen(strVar), SQLITE_TRANSIENT);  
        }
        sqlite3_bind_text(insertStatement, 2, boolVarString, strlen(boolVarString), SQLITE_TRANSIENT);
        sqlite3_bind_int(insertStatement, 3, cell.choiseVar);
        sqlite3_bind_text(insertStatement, 4, dateString, strlen(dateString), SQLITE_TRANSIENT);
        sqlite3_bind_blob(insertStatement, 5, [image bytes], [image length], SQLITE_TRANSIENT);
    
    
        sqlite3_step(insertStatement);
        sqlite3_finalize(insertStatement);
    }
    if (sqlite3_close(db))
        NSLog(@"DB: close error");
}

@end