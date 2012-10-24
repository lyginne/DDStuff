//
//  EditViewController.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"
#import "CellData.h"

@implementation EditViewController


@synthesize cellData=_cellData;
@synthesize strVarTextField;
@synthesize boolVarSwith;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //[self configureView];
    CellData *cellData = _cellData;
    
    
    if (cellData) {
        strVarTextField.text=cellData.stringVar;
        boolVarSwith.on=cellData.boolVar;
    }
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
