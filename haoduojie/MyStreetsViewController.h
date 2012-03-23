//
//  MyStreetsViewController.h
//  haoduojie
//
//  Created by  on 12-3-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoFlowController;
@interface MyStreetsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
    NSArray *streetInfos;
}
@property (nonatomic,retain) PhotoFlowController* photoFlowController;

@end
