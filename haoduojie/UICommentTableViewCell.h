//
//  UICommentTableViewCell.h
//  haoduojie
//
//  Created by  on 12-3-31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICommentTableViewCell : UITableViewCell {
    UILabel *intime;
    UIImageView *ownerHead;
    UILabel *ownerName;
    UITextView *content;
}

@property (retain, nonatomic) IBOutlet UIImageView *ownerHead;
@property (retain, nonatomic) IBOutlet UILabel *ownerName;
@property (retain, nonatomic) IBOutlet UITextView *content;

@property (retain, nonatomic) IBOutlet UILabel *intime;

@end
