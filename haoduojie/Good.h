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
@property int streetFriendsNum;
@property int likeNum;
@property float price;
@property BOOL isUserLike;

@property (nonatomic, retain) NSString* priceType;
@property (nonatomic, retain) NSString* goodName;
@property (nonatomic, retain) NSString* goodImage;
@property (nonatomic, retain) NSString* goodImageLarge;
@property (nonatomic, retain) NSString* ownerName;
@property (nonatomic, retain) NSString* streetName;
@property (nonatomic, retain) NSString* ownerHead;
@end
