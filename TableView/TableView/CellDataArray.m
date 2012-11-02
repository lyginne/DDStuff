//
//  CellDataController.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellDataArray.h"
#import "CellData.h"
#import "OperationsWithDataSource.h"
@interface CellDataArray (Local)

- (void)initializeDataList;

@end

@implementation CellDataArray

static NSMutableArray *cellDataArray;
+(NSMutableArray *)getArray
{
    return cellDataArray;
}

+ (void) replaceInArrayAtIndex:(NSInteger)index withCell:(CellData *)cellData
{
    [cellDataArray replaceObjectAtIndex:index withObject:cellData];
}
+(void)removeInArrayAtIndex:(NSUInteger)index
{
    [cellDataArray removeObjectAtIndex:index];
}

+(void) addInArrayCellData: (CellData *) cellData
{
    [cellDataArray addObject:cellData];
}

- (id)init {
    
    //redefine default init
    
    self=[super init];
    cellDataArray  = [[NSMutableArray alloc] init];
    [OperationsWithDataSource loadCellDataArray];
    return self;
}

+ (NSUInteger)countOfArray {
    
    //Count array's elements
    
    return [cellDataArray count];
}

+ (CellData *)objectInArrayAtIndex:(NSUInteger)theIndex {
    
    //get object from array at index
    
    return [cellDataArray objectAtIndex:theIndex];
}

+(void) dealloc
{
    [cellDataArray release];
    [super dealloc];
}
@end
