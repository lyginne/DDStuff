//
//  CellDataController.h
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CellData;

@interface CellDataArray : NSObject

+ (NSUInteger) countOfArray;
+ (CellData *) objectInArrayAtIndex:(NSUInteger)theIndex;
+ (void) replaceInArrayAtIndex:(NSInteger)index withCell:cell;
+ (void) addInArrayCellData: (CellData *) cellData;
+ (void) removeInArrayAtIndex:(NSUInteger)index;
+(NSMutableArray *)getArray;

@end
