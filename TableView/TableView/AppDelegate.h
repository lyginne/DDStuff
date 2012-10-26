//
//  AppDelegate.h
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CellDataController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (retain, nonatomic) UIWindow *window;
@property (retain) CellDataController *leakedArray;

@end
