//
//  StreetSelectingController.h
//  haoduojie
//
//  Created by  on 12-4-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StreetSelectingController : UITableViewController<UITableViewDelegate, UITableViewDataSource>{
    NSMutableArray* toStreets;
    NSMutableArray* allMyStreets;
    NSMutableDictionary* selectedCells;
    UIAlertView* alert;
}
@property (nonatomic, retain) NSMutableArray* toStreets;
@property (nonatomic, retain) NSMutableArray* allMyStreets;

@end
