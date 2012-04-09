//
//  PriceTableViewCell.m
//  haoduojie
//
//  Created by  on 12-4-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PriceTableViewCell.h"

@implementation PriceTableViewCell
@synthesize label;
@synthesize price;
@synthesize priceSwitchBtn;
@synthesize priceTypePicker;

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
    [price release];
    [priceSwitchBtn release];
    [priceTypePicker release];
    [super dealloc];
}
@end
