//
//  EditDate.m
//  TableView
//
//  Created by Admin on 11/6/12.
//
//

#import "EditDateViewController.h"

@implementation EditDateViewController:UIViewController

@synthesize dateEditor;
@synthesize delegate;

-(void)viewWillAppear:(BOOL)animated{
    dateEditor.date=[[self delegate] getDate];
}

-(void)viewWillDisappear:(BOOL)animated{
    [[self delegate] setDate:dateEditor.date];
}

@end
