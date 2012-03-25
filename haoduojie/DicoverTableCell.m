//
//  DicoverTableCell.m
//  haoduojie
//
//  Created by  on 12-3-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "DicoverTableCell.h"

@implementation DicoverTableCell
@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize label1;
@synthesize label2;
@synthesize label3;

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

@end
