//
//  InfoEditTextFieldCell.m
//  haoduojie
//
//  Created by  on 12-4-5.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "InfoEditTextFieldCell.h"

@implementation InfoEditTextFieldCell
@synthesize label;
@synthesize input;



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
    [label release];
    [input release];
    [super dealloc];
}
@end
