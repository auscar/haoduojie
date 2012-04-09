//
//  Street.m
//  haoduojie
//
//  Created by  on 12-4-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Street.h"

@implementation Street
@synthesize streetId;
@synthesize streetName;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void)dealloc{
    [streetName release];
    [super dealloc];
}

@end













