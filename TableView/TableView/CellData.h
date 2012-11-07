//
//  CellData.h
//  TableView
//
//  Created by Mac on 24.10.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Foundation/Foundation.h>

@interface CellData : NSObject

@property (nonatomic, copy) NSString *stringVar;
@property (nonatomic) bool boolVar;
@property (nonatomic) int choiseVar;
@property (nonatomic, copy) NSDate *date;
@property (nonatomic, copy) UIImage *image;

-(id) initWithStringVar: (NSString *) stringVar
                boolVar: (bool) boolVar
              choiseVar: (int) choiseVar
                   date: (NSDate *) date
                  image: (UIImage *) image;

@end
