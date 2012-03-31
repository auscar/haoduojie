//
//  Tools.m
//  haoduojie
//
//  Created by  on 12-3-31.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "Tools.h"

@implementation Tools

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(void)scrollViewContentSizeVerticalFit:(UIScrollView *)scrollView{
    CGFloat scrollViewHeight = 0.0f;
    for (UIView* view in scrollView.subviews)
    {
        if (!view.hidden)
        {
            CGFloat y = view.frame.origin.y;
            CGFloat h = view.frame.size.height;
            if (y + h > scrollViewHeight)
            {
                scrollViewHeight = h + y;
            }
        }
    }
    
    [scrollView setContentSize:(CGSizeMake(scrollView.frame.size.width, scrollViewHeight))];
}

+(void)scrollViewContentSizeHorizontalFit:(UIScrollView *)scrollView{
    CGFloat scrollViewWidth = 0.0f;
    for (UIView* view in scrollView.subviews)
    {
        if (!view.hidden)
        {
            CGFloat y = view.frame.origin.y;
            CGFloat h = view.frame.size.height;
            if (y + h > scrollViewWidth)
            {
                scrollViewWidth = h + y;
            }
        }
    }
    [scrollView setContentSize:(CGSizeMake(scrollViewWidth,scrollView.frame.size.width))]; 
}
+(CGFloat)getViewContentHeight:(UIView *)targetView{
    CGFloat viewContentHeight = 0.0f;
    for (UIView* view in targetView.subviews)
    {
        if (!view.hidden)
        {
            CGFloat y = view.frame.origin.y;
            CGFloat h = view.frame.size.height;
            if (y + h > viewContentHeight)
            {
                viewContentHeight = h + y;
            }
        }
    }
    return viewContentHeight;
}
+(void)view:(UIView *)view ScaleToHeight:(CGFloat)height{
    view.frame = CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, height);
}
+(CGFloat)getText:(NSString*)text heightWithWidth:(CGFloat)width andWithFont:(UIFont *)font{
    
    //设定一个框框, 然后下面的代码就是算在这个框框下content究竟要占用多高的空间
    CGSize bound = CGSizeMake(width, 2000.0f);//text的高度不能高于2000呀, 不然就算错了
    //算出空间
    CGSize textSize = [text sizeWithFont:font constrainedToSize:bound lineBreakMode:UILineBreakModeWordWrap];
    
    return textSize.height;
}
@end







