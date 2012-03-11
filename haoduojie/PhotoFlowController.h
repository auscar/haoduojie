//
//  PhotoFlowController.h
//  haoduojie
//
//  Created by  on 12-3-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyFavStreetsViewController.h"
#import "MyStreetsViewController.h"
#import "PhotoFlow.h"

//@class PhotoFlow;
@interface PhotoFlowController : UIViewController<UITabBarControllerDelegate>{
    CGPoint touchBeganPoint;
    NSArray *photos1;
    NSArray *photos2;
    
    MyFavStreetsViewController *myFavStreets;
    MyStreetsViewController *myOwnStreets;
    UIView *bottomBoard;
    UIView *photoFlowBoard;
    UITableView *table1;
    UITableView *table2;
    PhotoFlow *pf1;
    PhotoFlow *pf2;
    
    BOOL photoBoardIsOutOfStage;
}

@property (retain, nonatomic) IBOutlet MyFavStreetsViewController *myFavStreets;
@property (retain, nonatomic) IBOutlet MyStreetsViewController *myOwnStreets;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;

@property (retain, nonatomic) IBOutlet UIView *bottomBoard;
@property (retain, nonatomic) IBOutlet UIView *photoFlowBoard;

@property (retain, nonatomic) IBOutlet UITableView *table1;
@property (retain, nonatomic) IBOutlet UITableView *table2;

@property (retain, nonatomic) IBOutlet PhotoFlow *pf1;
@property (retain, nonatomic) IBOutlet PhotoFlow *pf2;

- (IBAction)ownBtnTapped:(id)sender;
- (IBAction)favBtnTapped:(id)sender;

@end
