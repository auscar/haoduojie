//
//  CommentTableViewCell.h
//  haoduojie
//
//  Created by  on 12-4-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell {
    UIImageView *ownerHead;
    UILabel *ownerName;
    UILabel *intime;
    UITextView *commentContent;
}

@property (retain, nonatomic) IBOutlet UIImageView *ownerHead;
@property (retain, nonatomic) IBOutlet UILabel *ownerName;
@property (retain, nonatomic) IBOutlet UILabel *intime;
@property (retain, nonatomic) IBOutlet UITextView *commentContent;

@end
