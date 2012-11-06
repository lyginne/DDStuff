//
//  EditViewController.h
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EditDateViewController.h"

@class CellData;
@class CellDataArray;

@interface EditViewController : UITableViewController <EditDateViewControllerDelegate, UIPopoverControllerDelegate>

@property (retain, nonatomic) IBOutlet UITextField *strVarTextField;
@property (retain, nonatomic) IBOutlet UISwitch *boolVarSwith;
@property (retain, nonatomic) IBOutlet UIButton *button;

+(void) setMasterSelectIndex:(NSUInteger) index;

@end
