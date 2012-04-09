//
//  Street.h
//  haoduojie
//
//  Created by  on 12-4-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Street : NSObject{
    int streetId;
    NSString* streetName;
}

@property (nonatomic) int streetId;
@property (nonatomic,retain) NSString* streetName;

@end
