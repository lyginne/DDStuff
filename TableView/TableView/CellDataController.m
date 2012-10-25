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

static NSMutableArray *cellDataArray;



//@synthesize cellDataArray=_cellDataArray;
+ (void) replaceInArrayAtIndex:(NSInteger)index withCell:(CellData *)cellData
{
    [cellData retain];
    [cellDataArray replaceObjectAtIndex:index withObject:cellData];
}
- (void)initializeDataList {
    
    //Initialise Array of data, that will be used in t
    cellDataArray  = [[NSMutableArray alloc] init];
    CellData *cellData = [[CellData alloc] initWithStringVar:@"So, I'm Alive" boolVar: true choiseVar:2];
    [cellDataArray addObject:cellData];
    cellData = [[CellData alloc] initWithStringVar:@"Me to" boolVar: false choiseVar:4];
    [cellDataArray addObject:cellData];
}
- (id)init {
    
    //redefine default init
    
    if (self = [super init]) {
        [self initializeDataList];
        return self;
    }
    return nil;
}
+ (NSUInteger)countOfList {
    
    //Count array's elements
    
    return [cellDataArray count];
}
+ (CellData *)objectInArrayAtIndex:(NSUInteger)theIndex {
    
    //get object from array at index
    
    return [cellDataArray objectAtIndex:theIndex];
}

@end
