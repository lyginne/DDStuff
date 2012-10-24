//
//  CellDataController.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellDataController.h"
#import "CellData.h"

@implementation CellDataController

@synthesize cellDataArray=_cellDataArray;

- (void)initializeDataList {
    
    //Initialise Array of data, that will be used in table
    
    _cellDataArray  = [[NSMutableArray alloc] init];
    CellData *cellData = [[CellData alloc] initWithStringVar:@"So, I'm Alive" boolVar: true choiseVar:4];
    [self.cellDataArray addObject:cellData];
    cellData = [[CellData alloc] initWithStringVar:@"Me to" boolVar: true choiseVar:4];
    [self.cellDataArray addObject:cellData];
}
- (id)init {
    
    //redefine default init
    
    if (self = [super init]) {
        [self initializeDataList];
        return self;
    }
    return nil;
}
- (NSUInteger)countOfList {
    
    //Count array's elements
    
    return [_cellDataArray count];
}
- (CellData *)objectInArrayAtIndex:(NSUInteger)theIndex {
    
    //get object from array at index
    
    return [_cellDataArray objectAtIndex:theIndex];
}

@end
