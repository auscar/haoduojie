//
//  ButtonHelper.m
//  zhamr
//
//  Created by  on 11-9-30.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "ButtonHelper.h"

#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
@implementation ButtonHelper

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
+(UISegmentedControl *) makeSigmentButtonWithTitle:(NSString *)title{
    NSArray *ary = [[NSArray alloc] initWithObjects:title,nil];
    UISegmentedControl *sig = [[UISegmentedControl alloc] initWithItems:ary];
    [sig setMomentary:YES];
    [sig setSegmentedControlStyle:UISegmentedControlStyleBar];
    [sig setTintColor:RGBA(77, 165, 227, 1)];
    return sig;
}
@end
