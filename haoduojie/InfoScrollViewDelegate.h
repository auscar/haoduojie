//
//  InfoScrollViewDelegate.h
//  haoduojie
//
//  Created by  on 12-4-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class InfoScrollView;
@protocol InfoScrollViewDelegate <NSObject>

-(int)countOfItems;
-(int)widthOfEachItem;
-(int)heightOfEachItem;
-(int)paddingOfEachItem;
-(UIView*)viewForIndex:(int)index ofScrollView:(InfoScrollView*)scrollView;

@end
