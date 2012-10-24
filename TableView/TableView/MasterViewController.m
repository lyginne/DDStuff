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

@implementation MasterViewController

@synthesize dataController=_dataController;

- (void)awakeFromNib
{
    //Prepairing to service
    
    [super awakeFromNib];
    self.dataController = [[CellDataController alloc] init];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //How many rows we need?
    
    return [self.dataController countOfList];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //Attaches cell to its data
    
    static NSString *CellIdentifier = @"CellWithData";
    
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    CellData *cellDataAtIndex = [self.dataController objectInArrayAtIndex:indexPath.row];
    [[cell textLabel] setText:cellDataAtIndex.stringVar];
    return cell;
}



@end