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
#import "CustomStatusBar.h"
@interface GoodPublishController : UIViewController<InfoScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate> {
    Good* good;
    UITableView *infoTable;
    InfoScrollView *photoScrollView;
    UIControl* controlEditing;
    UITapGestureRecognizer* tap;
    CustomStatusBar* _customStatusBar;
    
    NSArray* infoArray;
    NSArray* infoFieldName;
    NSMutableArray* photoArray;
    NSMutableDictionary* infoFieldValue;
    
    //fields
    UITextField* title;
    UITextField* desc;
    UITextField* price;
    UITextField* to;
    UISwitch* weibo;
    
}


@property (retain, nonatomic) IBOutlet UITableView *infoTable;
@property (retain, nonatomic) IBOutlet InfoScrollView *photoScrollView;
@property (retain, nonatomic) IBOutlet Good* good;

@end
