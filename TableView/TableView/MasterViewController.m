//
//  MasterViewController.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellDataArray.h"
#import "CellData.h"
#import "MasterViewController.h"
#import "Cell.h"
#import "EditViewController.h"
#import "OperationsWithDataSource.h"

#define FIRST_CHOISE 0
#define SECOND_CHOISE 1
#define THIRD_CHOISE 2

@implementation MasterViewController


-(BOOL)tableView: (UITableView *) tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        //add code here for when you hit delete
        [CellDataArray removeInArrayAtIndex:indexPath.row];
        [tableView reloadData];
        [OperationsWithDataSource saveData];
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    [OperationsWithDataSource saveData];
    
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //How many rows we need?
    
    return [CellDataArray countOfArray];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Attaches cell to its data


    static NSString *CellIdentifier = @"CellWithData";
    Cell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];    
    CellData *cellDataAtIndex = [CellDataArray objectInArrayAtIndex:indexPath.row];
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
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    cell.dateLabel.text=[dateFormat stringFromDate:cellDataAtIndex.date];
    [dateFormat release];
    cell.MyimageView.image=cellDataAtIndex.image;
    cell.MyimageView.contentMode=UIViewContentModeScaleAspectFit;
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"EditCell"]) {        
        [EditViewController setMasterSelectIndex:[self.tableView indexPathForSelectedRow].row];
    }
    if ([[segue identifier] isEqualToString:@"AddCell"])
    {
        CellData *celldata=[[CellData alloc] init];
        [CellDataArray addInArrayCellData:celldata];
        [EditViewController setMasterSelectIndex:[CellDataArray countOfArray]-1];
        [celldata release];
    }
}

-(void)dealloc
{
    [super dealloc];
}

@end