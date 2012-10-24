//
//  Cell.h
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cell : UITableViewCell
@property (retain, nonatomic) IBOutlet UILabel *strLabel;
@property (retain,nonatomic) IBOutlet UISwitch *boolVar;
@property (retain, nonatomic) IBOutlet UILabel *choiseVarString;
@end
