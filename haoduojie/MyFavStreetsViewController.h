//
//  MyFavStreetsViewController.h
//  haoduojie
//
//  Created by  on 12-3-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PhotoFlowController;

@interface MyFavStreetsViewController : UITableViewController <UITableViewDelegate, UITableViewDataSource>{
    NSArray *streetInfos;
    PhotoFlowController* photoFlowController;
    
}
@property (nonatomic,retain) IBOutlet PhotoFlowController* photoFlowController;
@end
