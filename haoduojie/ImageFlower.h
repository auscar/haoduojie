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
@class ImageFlow;
@interface ImageFlower : UIViewController<ImageFlowDelegate, ImageFlowDataSource>{
    ImageFlow* imgf;
    NSMutableArray* items;
    NSMutableArray* images;
}

//-(IBAction)loadArrayAction:(id)sender;
-(void)loadFromURL:(NSString*)url;

@end
