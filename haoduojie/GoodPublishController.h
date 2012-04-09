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
#import "Street.h"
#import "CustomStatusBar.h"
#import "WBEngine.h"
#import "WeiboLoginController.h"
@interface GoodPublishController : UIViewController<InfoScrollViewDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,UIImagePickerControllerDelegate,UIPickerViewDelegate, WBEngineDelegate> {
    Good* good;
    InfoScrollView *uploadScrollView;
    UITableView *infoTable;
    InfoScrollView *photoScrollView;
    UIControl* controlEditing;
    UITapGestureRecognizer* tap;
    CustomStatusBar* _customStatusBar;
    UIAlertView* alert;
    UISegmentedControl* bindWeibo;
    
    
    NSArray* infoArray;
    NSArray* infoFieldName;
    NSMutableArray* photoArray;
    NSMutableArray* toStreets;
    NSMutableDictionary* infoFieldValue;
    
    //fields
    UITextField* title;
    UITextField* desc;
    UITextField* price;
    UITextField* to;
    UISwitch* weibo;
    UISwitch* priceSwitch;
    
    UIButton* buttonTapForTakingPhoto;
    NSMutableDictionary* photosTaken;
    
    WBEngine* WeiboEngine;
   
    
}


@property (retain, nonatomic) IBOutlet UITableView *infoTable;
//@property (retain, nonatomic) IBOutlet InfoScrollView *photoScrollView;
@property (retain, nonatomic) IBOutlet Good* good;
@property (retain, nonatomic) IBOutlet InfoScrollView *uploadScrollView;

@end
