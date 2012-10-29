//
//  EditViewController.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"
#import "CellData.h"
#import "CellDataArray.h"

@interface EditViewController (locals)

- (void)placeTiksAsNeededForChoise: (NSUInteger) choise;

@end

@implementation EditViewController
static NSInteger masterSelectIndex, editSelectIndexRow;

@synthesize strVarTextField;
@synthesize boolVarSwith;

+(void) setMasterSelectIndex:(NSUInteger) index
{
    masterSelectIndex=index;
}

- (void)viewWillAppear:(BOOL)animated
{
    // Do any additional setup after loading the view, typically from a nib.
    
    strVarTextField.text=[CellDataArray objectInArrayAtIndex:masterSelectIndex].stringVar ;
    boolVarSwith.on=[CellDataArray objectInArrayAtIndex:masterSelectIndex ].boolVar;
    editSelectIndexRow=[CellDataArray objectInArrayAtIndex:masterSelectIndex].choiseVar;
}                                  
                            
                                   
-(void)viewWillDisappear:(BOOL)animated
{
    CellData * cellData=[[CellData alloc] init ];
    [cellData setBoolVar:boolVarSwith.on];
    [cellData setStringVar:strVarTextField.text];
    [cellData setChoiseVar:editSelectIndexRow];
    [CellDataArray replaceInArrayAtIndex:masterSelectIndex withCell:cellData];
    [cellData release];
    
}

- (void)viewDidUnload {
    [self setStrVarTextField:nil];
    [self setBoolVarSwith:nil];
    [self setTableView:nil];
    [super viewDidUnload];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if ([indexPath row] == editSelectIndexRow)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    editSelectIndexRow=indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [tableView reloadData];

}

-(void) dealloc
{
    [strVarTextField release];
    [boolVarSwith release];

    [super dealloc];
}

@end
