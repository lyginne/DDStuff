//
//  CellDataController.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellDataArray.h"
#import "CellData.h"
@interface CellDataArray (Local)

- (void)initializeDataList;

@end

@implementation CellDataArray

static NSMutableArray *cellDataArray;

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

- (void)initializeDataList {
    
    //Initialise Array of data, that will be used in tableview
    //Will be deleted, when xml will be successfully parsed
    cellDataArray  = [[NSMutableArray alloc] init];
    CellData *cellData = [[CellData alloc] initWithStringVar:@"So, I'm Alive" boolVar: true choiseVar:2];
    [cellDataArray addObject:cellData];
    [cellData release];
    cellData = [[CellData alloc] initWithStringVar:@"Me to" boolVar: false choiseVar:3];
    [cellDataArray addObject:cellData];
    [cellData release];
}

- (id)init {
    
    //redefine default init
    
    self=[super init];
    [self initializeDataList];
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
