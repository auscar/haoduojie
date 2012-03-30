//
//  ImageFlowerButton.m
//  haoduojie
//
//  Created by  on 12-3-26.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageFlowerButton.h"

@implementation ImageFlowerButton

@synthesize good;


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
-(void) dealloc{
    [good release];
    [super dealloc];
}
@end
