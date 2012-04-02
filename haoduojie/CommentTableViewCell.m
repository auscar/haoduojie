//
//  CommentTableViewCell.m
//  haoduojie
//
//  Created by  on 12-4-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "CommentTableViewCell.h"

@implementation CommentTableViewCell
@synthesize ownerHead;
@synthesize ownerName;
@synthesize intime;
@synthesize commentContent;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)dealloc {
    [ownerHead release];
    [ownerName release];
    [intime release];
    [commentContent release];
    [super dealloc];
}
@end
