//
//  Good.h
//  haoduojie
//
//  Created by  on 12-3-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Good : NSObject

@property int goodId;
@property int ownerId;
@property int streetId;
@property (nonatomic, retain) NSString* goodName;
@property (nonatomic, retain) NSString* ownerName;
@property (nonatomic, retain) NSString* streetName;
@end
