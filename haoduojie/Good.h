//
//  Good.h
//  haoduojie
//
//  Created by  on 12-3-29.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Good : NSObject

@property (assign) int goodId;
@property (assign) int ownerId;
@property (assign) int streetId;
@property (assign) int streetFriendsNum;
@property (assign) int likeNum;
@property (assign) float price;
@property (assign) BOOL isUserLike;

@property (nonatomic, retain) NSString* priceType;
@property (nonatomic, retain) NSString* goodName;
@property (nonatomic, retain) NSString* goodImage;
@property (nonatomic, retain) NSString* goodImageLarge;
@property (nonatomic, retain) NSString* ownerName;
@property (nonatomic, retain) NSString* streetName;
@property (nonatomic, retain) NSString* ownerHead;
@end
