//
//  ImageFlowerDelegate.h
//  haoduojie
//
//  Created by  on 12-3-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ImageFlower;

@protocol ImageFlowerDelegate <NSObject>
-(void)imageFlower:(ImageFlower*)flower flowerCellDidTappedWithTarget:(id)target;
@end
