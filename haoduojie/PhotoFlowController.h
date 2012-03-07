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


@interface PhotoFlowController : UIViewController{
    MyFavStreetsViewController *myFavStreets;
    MyStreetsViewController *myOwnStreets;
    UIView *bottomBoard;
    UIView *photoFlowBoard;
    
    BOOL photoBoardIsOutOfStage;
}

@property (retain, nonatomic) IBOutlet MyFavStreetsViewController *myFavStreets;
@property (retain, nonatomic) IBOutlet MyStreetsViewController *myOwnStreets;
@property (retain, nonatomic) IBOutlet UIToolbar *toolBar;

@property (retain, nonatomic) IBOutlet UIView *bottomBoard;
@property (retain, nonatomic) IBOutlet UIView *photoFlowBoard;

- (IBAction)ownBtnTapped:(id)sender;
- (IBAction)favBtnTapped:(id)sender;

@end
