//
//  CommentController.h
//  haoduojie
//
//  Created by  on 12-4-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomStatusBar.h"
#import "Good.h"
@interface CommentController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UITextView *commentTextView;
    UITableView *commentTable;
    CustomStatusBar* _customStatusBar;
    NSArray* commentArray;
    
    Good* good;
    UIScrollView *scrollView;
}
@property (assign) int goodId;
@property (retain, nonatomic) IBOutlet UITextView *commentTextView;
@property (retain, nonatomic) IBOutlet UITableView *commentTable;
@property (retain, nonatomic) Good* good;
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
-(IBAction) back;
-(IBAction)commentPost:(id)sender;
-(IBAction)onBodyTapped:(id)sender;
@end
