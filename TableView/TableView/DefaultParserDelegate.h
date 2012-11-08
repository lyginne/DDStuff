//
//  DefaultParserDelegate.h
//  TableView
//
//  Created by Mac on 07.11.12.
//
//

#import <Foundation/Foundation.h>
#import "CellDataArray.h"
#import "CellData.h"

@interface DefaultParserDelegate: NSObject <NSXMLParserDelegate>
{

// string to hold element value
NSMutableString *currentElementValue;

    
    // cell obj
    CellData *cell;
    
//    // array of cells
//    CellDataArray *cellDataArray;
    
    
    
    //string that holds current tag
    NSString *tag;
    NSError* m_error;

}

@property (nonatomic, retain) CellData *cell;
@property (nonatomic, retain) NSString *tag;
@property (readonly, retain) NSError* error;




//-(DefaultParserDelegate *) initXmlParser;

-(NSUInteger) countOfCells;



@end
