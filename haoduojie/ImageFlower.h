//
//  ImageFlower.h
//  demo
//
//  Created by  on 12-3-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageFlowDataSource.h"
#import "ImageFlowDelegate.h"
#import "ImageFlowerDelegate.h"

@class ImageFlow;
@interface ImageFlower : UIViewController<ImageFlowDelegate, ImageFlowDataSource>{
    ImageFlow* imgf;
    id<ImageFlowerDelegate> delegate; 
    NSMutableArray* items;
    NSMutableArray* images;
}

@property (nonatomic, retain) IBOutlet id<ImageFlowerDelegate> delegate;
//-(IBAction)loadArrayAction:(id)sender;
-(void)loadFromURL:(NSString*)url;

@end
