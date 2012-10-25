//
//  CellDataController.h
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CellData;

@interface CellDataController : NSObject
//+ (NSMutableArray *) getArray;
+ (NSUInteger)countOfList;
+ (CellData *)objectInArrayAtIndex:(NSUInteger)theIndex;
+ (void) replaceInArrayAtIndex:(NSInteger)index withCell:cell;
- (void)initializeDataList;
@end
