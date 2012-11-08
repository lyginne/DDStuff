//
//  ParseCellDataArray.h
//  TableView
//
//  Created by Admin on 10/31/12.
//
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface OperationsWithDataSource : NSObject
{
     sqlite3 *db;
}

+ (void)loadData;
+ (void)saveData;

@end
