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
+(void)scrollViewContentSizeHorizontalFit:(UIScrollView*)scrollView;
+(CGFloat)getViewContentHeight:(UIView*)view;
+(void)view:(UIView*)view ScaleToHeight:(CGFloat)height;
+(CGFloat)getText:(NSString*)text heightWithWidth:(CGFloat)width andWithFont:(UIFont*)font;
@end
