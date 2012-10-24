//
//  EditViewController.h
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CellData;
@class CellDataController;

@interface EditViewController : UITableViewController

@property (retain, nonatomic) CellData *cellData;
@property (retain, nonatomic) IBOutlet UITextField *strVarTextField;
@property (retain, nonatomic) IBOutlet UISwitch *boolVarSwith;

@end
