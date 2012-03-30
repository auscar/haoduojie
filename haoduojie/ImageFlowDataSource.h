//
//  ImageFlowDataSource.h
//  haoduojie
//
//  Created by  on 12-3-25.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ImageFlow;
@protocol ImageFlowDataSource <NSObject>

-(int)imageFlow:(ImageFlow*)flow heightForIndex:(int)index;
-(UIView*)imageFlow:(ImageFlow*)flow viewForIndex:(int)index;
-(int)countOfItems;
@end
