//
//  EditViewController.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"
#import "CellData.h"
#import "CellDataController.h"

@implementation EditViewController


@synthesize index;
@synthesize strVarTextField;
@synthesize boolVarSwith;


- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self configureView];
    
    
        strVarTextField.text=[CellDataController objectInArrayAtIndex:index].stringVar ;
        boolVarSwith.on=[CellDataController objectInArrayAtIndex:index].boolVar;
}
-(void)viewDidDisappear:(BOOL)animated
{
    CellData * cellData=[[CellData alloc] init ];
    [cellData setBoolVar:boolVarSwith.on];
    [cellData setStringVar:strVarTextField.text];
    [cellData setChoiseVar:2];
    [CellDataController replaceInArrayAtIndex:index withCell:cellData];
    [cellData release];
}
- (void)dealloc {
    [strVarTextField release];
    [boolVarSwith release];
    [strVarTextField release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setStrVarTextField:nil];
    [self setBoolVarSwith:nil];
    [self setStrVarTextField:nil];
    [super viewDidUnload];
}

@end
