//
//  Detail.m
//  haoduojie
//
//  Created by  on 12-4-3.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Detail.h"

@implementation Detail
@synthesize detailText;
@synthesize detailImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)dealloc {
  
    [detailImage release];
    [detailText release];
    [super dealloc];
}
@end
