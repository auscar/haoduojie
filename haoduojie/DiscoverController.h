//
//  DiscoverController.h
//  haoduojie
//
//  Created by  on 12-3-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DiscoverController : UIViewController<UITableViewDelegate,UITableViewDataSource>{
    NSArray* discoverList;
    NSArray* streetInfos;
}
@property (nonatomic, retain) IBOutlet UITableView* table;
@end
