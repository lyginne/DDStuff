//
//  MasterViewController.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellDataController.h"
#import "CellData.h"
#import "MasterViewController.h"
#import "Cell.h"

#define FIRST_CHOISE 0
#define SECOND_CHOISE 1
#define THIRD_CHOISE 2

@implementation MasterViewController

@synthesize dataController=_dataController;

- (void)awakeFromNib
{
    //Prepairing to service
    
    [super awakeFromNib];
    _dataController = [[CellDataController alloc] init];
    
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //How many rows we need?
    
    return [self.dataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Attaches cell to its data
    
    static NSString *CellIdentifier = @"CellWithData";
    
    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    CellData *cellDataAtIndex = [_dataController objectInArrayAtIndex:indexPath.row];
    cell.strLabel.text=cellDataAtIndex.stringVar;
    cell.boolVar.enabled=NO;
    switch (cellDataAtIndex.choiseVar) {
        case FIRST_CHOISE:
            cell.choiseVarString.text=@"First Choise";
            break;
        case SECOND_CHOISE:
            cell.choiseVarString.text=@"Second Choise";
            break;
        case THIRD_CHOISE:
            cell.choiseVarString.text=@"Third Choise";
            break;
            
        default:
            cell.choiseVarString.text=@"Something went wrong";            
            break;
    }
    //cell.boolVar.userInteractionEnabled=NO;
    //[[cell textLabel] setText:cellDataAtIndex.stringVar];
    return cell;
}



@end