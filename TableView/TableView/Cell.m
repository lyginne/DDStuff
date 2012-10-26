//
//  Cell.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Cell.h"

@implementation Cell
@synthesize stringVarLabel;
@synthesize choiseVarString;
@synthesize boolVarSwitch;
-(void)dealloc
{
    [stringVarLabel release];
    [choiseVarString release];
    [boolVarSwitch release];
    [super dealloc];
    
}
@end
