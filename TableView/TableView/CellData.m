//
//  CellData.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CellData.h"

@implementation CellData

@synthesize stringVar=_stringVar, boolVar=_boolVar, choiseVar=_choiseVar;

-(id) init
{
    self=[super init];
    self.stringVar=@"DefaultString";
    self.boolVar=YES;
    self.choiseVar=0;
    return self;
}
-(id) initWithStringVar: (NSString *) stringVar boolVar: (bool) boolVar choiseVar: (int) choiseVar; {
    
    //initialize whith variables, nothing else
    
    self=[super init];
    self.stringVar=stringVar;
    self.boolVar=boolVar;
    self.choiseVar=choiseVar;
    return self;

}
-(void)dealloc
{
    [_stringVar release];
    [super dealloc];
    
}
@end
