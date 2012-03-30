//
//  Good.m
//  haoduojie
//
//  Created by  on 12-3-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Good.h"

@implementation Good

@synthesize goodId;
@synthesize ownerId;
@synthesize streetId;

@synthesize goodName;
@synthesize ownerName;
@synthesize streetName;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
-(void) dealloc{
    [streetName release];
    [goodName release];
    [ownerName release];
    [super dealloc];
}
@end
