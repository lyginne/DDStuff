//
//  EditViewController.m
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditViewController.h"
#import "CellData.h"
#import "CellDataArray.h"

@implementation EditViewController {
    NSDate * _date;
    UIPopoverController *pop;
}
static NSInteger masterSelectIndex, editSelectIndexRow;


@synthesize strVarTextField;
@synthesize boolVarSwith;
@synthesize imgPicker;
@synthesize imageView;
@synthesize imgButton;

-(void)renewTitleOnButton{
    NSDateFormatter *dateFormat=[[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    [_button setTitle:[dateFormat stringFromDate:_date]forState:UIControlStateNormal];
    [dateFormat release];
}
-(void)setDate:(NSDate *) date{
    [_date release];
    _date=[date copy];
    [self renewTitleOnButton];
}
-(NSDate *) getDate{
    
    return _date;
}
-(IBAction)grabImage:(id)sender{
    
    imgPicker = [[UIImagePickerController alloc] init];
    //self.imgPicker.allowsImageEditing = YES;
    imgPicker.delegate = self;
    imgPicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pop=[[UIPopoverController alloc] initWithContentViewController:imgPicker];
    [pop presentPopoverFromRect:imgButton.frame
                         inView:self.view
       permittedArrowDirections:UIPopoverArrowDirectionAny
                       animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)img
                  editingInfo:(NSDictionary *)editInfo {
    
    imageView.image = img;
    [pop dismissPopoverAnimated:YES];
}

+(void) setMasterSelectIndex:(NSUInteger) index
{
    masterSelectIndex=index;
}

- (void)viewWillAppear:(BOOL)animated
{
    // Do any additional setup after loading the view, typically from a nib.
    
    strVarTextField.text=[CellDataArray objectInArrayAtIndex:masterSelectIndex].stringVar ;
    boolVarSwith.on=[CellDataArray objectInArrayAtIndex:masterSelectIndex ].boolVar;
    editSelectIndexRow=[CellDataArray objectInArrayAtIndex:masterSelectIndex].choiseVar;
    _date=[CellDataArray objectInArrayAtIndex:masterSelectIndex].date;
    [_date retain];
    [self renewTitleOnButton];
    //imageView.image=[CellDataArray objectInArrayAtIndex:masterSelectIndex].image;
    if([CellDataArray objectInArrayAtIndex:masterSelectIndex].image)
        imageView.image=[CellDataArray objectInArrayAtIndex:masterSelectIndex].image;
    else
        imageView.image=[UIImage imageNamed:@"N0.png"];
    
}                                  
                            
                                   
-(void)viewWillDisappear:(BOOL)animated
{
    CellData * cellData=[[CellData alloc] init ];
    [cellData setBoolVar:boolVarSwith.on];
    [cellData setStringVar:strVarTextField.text];
    [cellData setChoiseVar:editSelectIndexRow];
    [cellData setDate:_date];
    [cellData setImage:imageView.image];
    [CellDataArray replaceInArrayAtIndex:masterSelectIndex withCell:cellData];
    [cellData release];
    [_date release];
    
}

- (void)viewDidUnload {
    [self setStrVarTextField:nil];
    [self setBoolVarSwith:nil];
    [self setTableView:nil];
    //[self setDate:nil];
    [super viewDidUnload];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;

    if (([indexPath row] == editSelectIndexRow)&& [indexPath section] ==2)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    editSelectIndexRow=indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    [tableView reloadData];

}

-(void) dealloc
{
    [imageView release];
    [imgPicker release];
    [strVarTextField release];
    [boolVarSwith release];
    [super dealloc];
}

-(void)prepareForSegue:(UIStoryboardPopoverSegue *)segue sender:(id)sender{
    if([[segue identifier] isEqualToString:@"editDatePopover"]){
        [[segue destinationViewController]setDelegate:self];
    }
}

@end
