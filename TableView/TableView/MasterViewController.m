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
#import "EditViewController.h"

#define FIRST_CHOISE 0
#define SECOND_CHOISE 1
#define THIRD_CHOISE 2

@implementation MasterViewController



- (void)awakeFromNib
{
    


}
-(void) viewDidAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //How many rows we need?
    
    return [CellDataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Attaches cell to its data
    
    static NSString *CellIdentifier = @"CellWithData";
    
    
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    CellData *cellDataAtIndex = [CellDataController objectInArrayAtIndex:indexPath.row];
    cell.stringVarLabel.text=cellDataAtIndex.stringVar;
    cell.boolVarSwitch.enabled=NO;
    cell.boolVarSwitch.on=cellDataAtIndex.boolVar;
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
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender

{
    if ([[segue identifier] isEqualToString:@"EditCell"]) {
        EditViewController *editViewController = [segue destinationViewController];
        
        [editViewController setIndex:[self.tableView indexPathForSelectedRow].row];
    }
}




@end