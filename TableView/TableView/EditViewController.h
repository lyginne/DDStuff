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


@property (retain, nonatomic) IBOutlet UILabel *tik1;
@property (retain, nonatomic) IBOutlet UILabel *tik2;
@property (retain, nonatomic) IBOutlet UILabel *tik3;
@property (retain, nonatomic) IBOutlet UITextField *strVarTextField;
@property (retain, nonatomic) IBOutlet UISwitch *boolVarSwith;
+(void) setMasterSelectIndex:(NSUInteger) index;

@end
