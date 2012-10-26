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

@interface EditViewController (locals)

- (void)placeTiksAsNeededForChoise: (NSUInteger) choise;

@end

@implementation EditViewController
static NSInteger masterSelectIndex, editSelectIndexRow;




@synthesize tik1;
@synthesize tik2;
@synthesize tik3;
@synthesize strVarTextField;
@synthesize boolVarSwith;
+(void) setMasterSelectIndex:(NSUInteger) index
{
    masterSelectIndex=index;
}


- (void)viewDidAppear:(BOOL)animated
{
    // Do any additional setup after loading the view, typically from a nib.
    //[self configureView];
    //NSLog(@"%lu", [strVarTextField retainCount]);
    [strVarTextField retain];
    strVarTextField.text=[CellDataController objectInArrayAtIndex:masterSelectIndex].stringVar ;
    boolVarSwith.on=[CellDataController objectInArrayAtIndex:masterSelectIndex ].boolVar;
    editSelectIndexRow=[CellDataController objectInArrayAtIndex:masterSelectIndex].choiseVar;
    [self placeTiksAsNeededForChoise:editSelectIndexRow];
    
    [super viewDidLoad];
}

-(void)viewDidDisappear:(BOOL)animated
{
    CellData * cellData=[[CellData alloc] init ];
    [cellData setBoolVar:boolVarSwith.on];
    [cellData setStringVar:strVarTextField.text];
    [cellData setChoiseVar:editSelectIndexRow];
    [CellDataController replaceInArrayAtIndex:masterSelectIndex withCell:cellData];
    [cellData release];
    
    [super viewDidUnload];
}
- (void)viewDidUnload {
    [self setStrVarTextField:nil];
    [self setBoolVarSwith:nil];
    [self setStrVarTextField:nil];
    [self setTik1:nil];
    [super release];
    //[super viewDidUnload];
}
-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    editSelectIndexRow=indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [self placeTiksAsNeededForChoise:indexPath.row];

}
-(void) placeTiksAsNeededForChoise: (NSUInteger) choise
{
    switch (choise) {
        case 0:
            [tik1 setHidden:NO];
            [tik2 setHidden:YES];
            [tik3 setHidden:YES];
            break;
        case 1:
            [tik1 setHidden:YES];
            [tik2 setHidden:NO];
            [tik3 setHidden:YES];
            break;
        case 2:
            [tik1 setHidden:YES];
            [tik2 setHidden:YES];
            [tik3 setHidden:NO];
            break;
            
        default:
            break;
    }    
}
-(void) dealloc
{
    [strVarTextField release];
    [boolVarSwith release];
    [tik1 release];
    [tik2 release];
    [tik3 release];
    [super dealloc];
}

@end
