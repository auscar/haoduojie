//
//  GoodDetailController.h
//  haoduojie
//
//  Created by  on 12-3-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Good.h"
@interface GoodDetailController : UIViewController<UITableViewDelegate, UITableViewDataSource> {
    UIImageView *ownerHead;
    UILabel *ownerName;
    UILabel *goodName;
    UIImageView *goodImg;
    UILabel *goodLikeNum;
    UILabel *goodFrom;
    UITableView *goodCommentList;
    UILabel *price;
    UITableView *commentTable;
    
    NSArray* commentArray;
}


@property (nonatomic, retain) Good* good;
@property (retain, nonatomic) IBOutlet UIImageView *ownerHead;
@property (retain, nonatomic) IBOutlet UILabel *ownerName;
@property (retain, nonatomic) IBOutlet UILabel *goodName;
@property (retain, nonatomic) IBOutlet UIImageView *goodImg;
@property (retain, nonatomic) IBOutlet UILabel *goodLikeNum;
@property (retain, nonatomic) IBOutlet UILabel *goodFrom;
@property (retain, nonatomic) IBOutlet UITableView *goodCommentList;
@property (retain, nonatomic) IBOutlet UILabel *price;
@property (retain, nonatomic) IBOutlet UITableView *commentTable;

@end
