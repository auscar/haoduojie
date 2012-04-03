//
//  Tools.h
//  haoduojie
//
//  Created by  on 12-3-31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Tools : NSObject

+(void)scrollViewContentSizeVerticalFit:(UIScrollView*)scrollView;
+(void)scrollView:(UIScrollView*)scrollView contentSizeVerticalFitWithDerta:(int)derta;//derta是一个修正值, 有时候scrollViewContentSizeVerticalFit会算不准
+(void)scrollViewContentSizeHorizontalFit:(UIScrollView*)scrollView;
+(CGFloat)getViewContentHeight:(UIView*)view;
+(void)view:(UIView*)view ScaleToHeight:(CGFloat)height;
+(CGFloat)getText:(NSString*)text heightWithWidth:(CGFloat)width andWithFont:(UIFont*)font;
+(UIView*)getViewFromXib:(NSString*)xibName;
@end
