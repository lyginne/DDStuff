//
//  EditDate.h
//  TableView
//
//  Created by Admin on 11/6/12.
//
//

#import <UIKit/UIKit.h>

@protocol EditDateViewControllerDelegate <NSObject>

-(NSDate *) getDate;
-(void) setDate: (NSDate *) date;

@end

@interface EditDateViewController : UIViewController

@property (retain, nonatomic) IBOutlet UIDatePicker *dateEditor;
@property (nonatomic, assign) id <EditDateViewControllerDelegate> delegate;




@end
