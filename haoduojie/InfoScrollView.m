//
//  InfoScrollView.m
//  haoduojie
//
//  Created by  on 12-4-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "InfoScrollView.h"

@implementation InfoScrollView
@synthesize pageControl;
@synthesize infoScrollViewDelegate;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        itemResueMap = [[NSMutableDictionary alloc] init];
        self.pagingEnabled = YES;
        // 手势检测左右划动
        UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandle:)];
        [left setDirection:(UISwipeGestureRecognizerDirectionLeft)];
        [self addGestureRecognizer:left];
        
        UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandle:)];
        [right setDirection:(UISwipeGestureRecognizerDirectionRight)];
        [self addGestureRecognizer:right];
    }
    
    return self;
}

// 左右划动动作的处理函数
-(void) swipeHandle:(UISwipeGestureRecognizer *)recognizer{
    NSLog(@"swipe");
    if(recognizer.direction == UISwipeGestureRecognizerDirectionRight){
        NSLog(@"to right");
        if(pageControl.currentPage == 0)return;
        [pageControl setCurrentPage:(pageControl.currentPage-1)];
    }else{
        NSLog(@"to left");
        if(pageControl.currentPage == 2)return;
        [pageControl setCurrentPage:(pageControl.currentPage+1)];
    }
    
    NSLog(@"pager currentPage %d", pageControl.currentPage);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    self.contentOffset = CGPointMake(320.0f*pageControl.currentPage,0.0f);
    [UIView commitAnimations];
    
}

-(BOOL)isViewInTree:(UIView*)view{
    NSArray* sbvs = [self subviews];
    if ([sbvs count]) {
        for (int i=0; i<[sbvs count]; i++) {
            if(view == [sbvs objectAtIndex:i]){
                return YES;
            }
        }
    }
    return NO;
}
-(void)clear{
    NSArray* sbvs = [self subviews];
    if ([sbvs count]) {
        for (int i=0; i<[sbvs count]; i++) {
            [[sbvs objectAtIndex:i] removeFromSuperview];
        }
    }
}
-(void)pinViewForIndex:(int)index{
    
    UIView* view = [infoScrollViewDelegate viewForIndex:index ofScrollView:self];
    int itemWidth = [infoScrollViewDelegate widthOfEachItem];
    int itemHeight = [infoScrollViewDelegate heightOfEachItem];
    int padding = [infoScrollViewDelegate paddingOfEachItem];
    if (index) {
        view.frame = CGRectMake((index+1)*padding+(index*itemWidth), padding, itemWidth, itemHeight);
    }else{
        view.frame = CGRectMake(padding+(index*itemWidth), padding, itemWidth, itemHeight);
    }
    
    
    if (![self isViewInTree:view]) {
        [self addSubview:view];
    }
    
}
-(void)cacheView:(UIView*)view withIdentifier:(id)identifier{
    [itemResueMap setObject:view forKey:identifier];
}
-(UIView*)getReusableViewIdentifiedBy:(id)identifier{
    return [itemResueMap objectForKey:identifier];
}

-(void)loadData{
    //计算这个infoScrollView需要多长的width
    int width = [infoScrollViewDelegate countOfItems]*([infoScrollViewDelegate widthOfEachItem]+[infoScrollViewDelegate paddingOfEachItem]) + [infoScrollViewDelegate paddingOfEachItem];
    
    //self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, width, self.frame.size.height);
    [self clear];//先清空原有的views
    
    for (int i=0; i<[infoScrollViewDelegate countOfItems]; i++) {
        [self pinViewForIndex:i];
    }
    NSLog(@"InforScrollView的width: %d", width);
    self.contentSize = CGSizeMake(width, self.frame.size.height);
}
- (void)dealloc {
    [pageControl release];
    [super dealloc];
}
@end
