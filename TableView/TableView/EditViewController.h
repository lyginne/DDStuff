//
//  EditViewController.h
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CellData;
@class CellDataArray;

@interface EditViewController : UITableViewController

@property (retain, nonatomic) IBOutlet UITextField *strVarTextField;
@property (retain, nonatomic) IBOutlet UISwitch *boolVarSwith;

+(void) setMasterSelectIndex:(NSUInteger) index;

@end
