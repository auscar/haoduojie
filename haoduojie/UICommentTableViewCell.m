//
//  UICommentTableViewCell.m
//  haoduojie
//
//  Created by  on 12-3-31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "UICommentTableViewCell.h"

@implementation UICommentTableViewCell
@synthesize ownerHead;
@synthesize ownerName;
@synthesize content;
@synthesize intime;

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
    [content release];
    [content release];
    [super dealloc];
}
@end
