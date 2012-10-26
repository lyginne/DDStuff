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
    if (self)
    {
        _stringVar=@"DefaultString";
        _boolVar=YES;
        _choiseVar=0;
        return self;
    }
    return nil;
}
-(id) initWithStringVar: (NSString *) stringVar boolVar: (bool) boolVar choiseVar: (int) choiseVar; {
    
    //initialize whith variables, nothing else
    
    self=[super init];
    if (self)
    {
        _stringVar=stringVar;
        _boolVar=boolVar;
        _choiseVar=choiseVar;
        return self;
    }
    return nil;
}
-(void)dealloc
{
    [_stringVar release];
    [super dealloc];
    
}
@end
