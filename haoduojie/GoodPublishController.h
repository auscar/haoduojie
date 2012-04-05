//
//  GoodPublishController.h
//  haoduojie
//
//  Created by  on 12-4-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoScrollViewDelegate.h"
#import "Good.h"
@interface GoodPublishController : UIViewController<InfoScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    Good* good;
    UITableView *infoTable;
    InfoScrollView *photoScrollView;
    UIControl* controlEditing;
    UITapGestureRecognizer* tap;
    
    NSArray* infoArray;
    NSArray* infoFieldName;
    NSMutableArray* photoArray;
    NSMutableDictionary* infoFieldValue;
    
}


@property (retain, nonatomic) IBOutlet UITableView *infoTable;
@property (retain, nonatomic) IBOutlet InfoScrollView *photoScrollView;
@property (retain, nonatomic) IBOutlet Good* good;

@end
