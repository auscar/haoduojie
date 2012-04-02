//
//  ImageFlow.m
//  demo
//
//  Created by  on 12-3-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageFlow.h"

@implementation ImageFlow
@synthesize delegate;
@synthesize images;
@synthesize view;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        scrollview = [[UIScrollView alloc] init];
        scrollview.delegate = self;
        scrollview.scrollEnabled = YES;
        
        scrollview.frame = CGRectMake(0, 0, 320, 460);
        
        trip1 = [[UIView alloc] initWithFrame:CGRectMake(6, 0, 151, 1000)];
        trip2 = [[UIView alloc] initWithFrame:CGRectMake(163, 0, 151, 1000)];
    
        [scrollview addSubview:trip1];
        [scrollview addSubview:trip2];
        
        view = scrollview;
    }
    
    return self;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super init];
    if (self) {
        // Initialization code here.
        scrollview = [[UIScrollView alloc] init];
        scrollview.delegate = self;
        scrollview.scrollEnabled = YES;
        //scrollview.pagingEnabled = YES;
        
        scrollview.frame = frame;
        
        
        //trip1 = [[UIView alloc] initWithFrame:CGRectMake(6, 0, 151, 1000)];
        //trip2 = [[UIView alloc] initWithFrame:CGRectMake(163, 0, 151, 1000)];
        
        trip1 = [[UIView alloc] init];
        trip2 = [[UIView alloc] init];
        
        [scrollview addSubview:trip1];
        [scrollview addSubview:trip2];
        
        view = scrollview;
    }
    
    return self;
}


#pragma mark 
-(CGFloat) getHeight:(UIImage *)image withWidth:(CGFloat)width{
    if(!image)return 0.0f;
    
    CGFloat rate = image.size.height/image.size.width;
    
    return floor(width*rate);
    
}
-(void) toFit{
    [trip1 sizeToFit];
    [trip2 sizeToFit];
    [view sizeToFit];
}
-(void) loadData{
    [self calculatePosition];
    [self logImagePos];
    [self check];
}
-(void) clearFlow{
    NSArray* svs1 = [trip1 subviews];
    
    if ([svs1 count]) {
        for (int j=0; j<[svs1 count]; j++) {
            [[svs1 objectAtIndex:j] removeFromSuperview];
        }
    }
    NSArray* svs2 = [trip2 subviews];
    if ([svs2 count]) {
        for (int i=0; i<[svs2 count]; i++) {
            [[svs2 objectAtIndex:i] removeFromSuperview];
        }
    }
}
-(void) calculatePosition{
    
    //移除所有的view
    [self clearFlow];
    
    CGFloat imageHeight;
    //NSArray *tempArray = [[NSArray alloc] init];
    
    imagePos = [[NSMutableArray alloc] init];
    imageHeights = [[NSMutableArray alloc] init];
    
    for (int k=0; k<[self.delegate countOfItems]; k++) {
        [imagePos addObject:[NSNumber numberWithInt:0]];
        [imageHeights addObject:[NSNumber numberWithInt:0]];
    }
    
    imageViewsCache = [[NSMutableDictionary alloc] init];
    cellIsInViewTreeMap = [[NSMutableDictionary alloc] init];
    
    
    offset1 = 0;
    offset2 = 0;
    
    //遍历数组内的图片, 计算他们的位置
    for (int i=0; i<[self.delegate countOfItems]; i++) {
        
        //------------------ 计算图片高度 --------------------------
        imageHeight = [self.delegate imageFlow:self heightForIndex:i];
        //记录这张图片的高度
        [imageHeights replaceObjectAtIndex:i withObject:[NSNumber numberWithFloat:imageHeight]];
        
        // ----------------- 计算图片应该在的位置 --------------------
        if(i%2==0){//第一列
            [imagePos replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:offset1 ]];
            offset1 += (imageHeight + 7);
        }else{//第二列
            [imagePos replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:offset2 ]];
            offset2 += (imageHeight + 7);
        }
    }
    
    //calculate之后, 拿它最后两个元素计算contentSize
    int lastPos = [[imagePos objectAtIndex:([self.delegate countOfItems]-1)] intValue];
    lastPos = lastPos + [[imageHeights objectAtIndex:([self.delegate countOfItems]-1)] intValue] + 6;
    
    if ([self.delegate countOfItems] > 1) {
        int lastPos2 = [[imagePos objectAtIndex:([self.delegate countOfItems]-2)] intValue];
        lastPos2 = lastPos2 + [[imageHeights objectAtIndex:([self.delegate countOfItems]-2)] intValue] + 6;
        if (lastPos2>lastPos) {
            lastPos = lastPos2;
        }
    }
    
    scrollview.contentSize = CGSizeMake(320, lastPos);
    trip1.frame = CGRectMake(6, 0, 151, lastPos);
    trip2.frame = CGRectMake(163, 0, 151, lastPos);
    
}
-(void) logImagePos{
    
}
-(void) removeCellForIndex:(int)index{
    NSNumber* num = [NSNumber numberWithInt:index];
    BOOL isIn = [[cellIsInViewTreeMap objectForKey:num] boolValue];

    //在view tree上的view才remove
    if (isIn) {
        [[imageViewsCache objectForKey:[NSNumber numberWithInt:index]] removeFromSuperview];
        [cellIsInViewTreeMap setObject:[NSNumber numberWithBool:NO] forKey:[NSNumber numberWithInt:index]];
    }
}

-(void) setCellForIndex:(int)index{
    NSNumber* num = [NSNumber numberWithInt:index];
    BOOL isIn = [[cellIsInViewTreeMap objectForKey:num] boolValue];
    
    // 不在view tree上就插入一个~   
    if (!isIn) {
        [self pinView:[self.delegate imageFlow:self viewForIndex:index]  withIndex:index];
    }
}

-(void) check{
    CGPoint loc = [scrollview contentOffset];
    int tmp;
    int imgHeight;
    UIImageView* iv;
    NSNumber* num;
    
    for (int i=0; i<[self.delegate countOfItems]; i++) {
        imgHeight = [self.delegate imageFlow:self heightForIndex:i];
        tmp = [[imagePos objectAtIndex:i] intValue];
        iv = [imageViewsCache objectForKey:[NSNumber numberWithInt:i]];//获取缓存的view
        
        num = [NSNumber numberWithInt:i];
        
        //可视区域内的图片需要显示
        if ( (tmp>=loc.y&&(tmp<=loc.y+460))||(((tmp+imgHeight)>=loc.y)&&(tmp+imgHeight<=loc.y+460)) ) {
            [self setCellForIndex:i];
        }else{
            [self removeCellForIndex:i];
        }
    }
}

-(UIView*)getCacheViewForIndex:(int)index{
    return [imageViewsCache objectForKey:[NSNumber numberWithInt:index]];
}
-(void) pinView:(UIView*)itemView withIndex:(int)index{
    int x = 0;
    int y;
    int width = 151;
    int height = 180;
    
    y = [[imagePos objectAtIndex:index] intValue];
    height = [self.delegate imageFlow:self heightForIndex:index];
    
    //UIView* itemView;
    /*
    itemView = [imageViewsCache objectForKey:[NSNumber numberWithInt:index]];
    if (!itemView) {
        
    }
     */
    
    //itemView = [self.delegate imageFlow:self viewForIndex:index];
    
    //缓存这个view
    [imageViewsCache setObject:itemView forKey:[NSNumber numberWithInt:index]];
    
    
    itemView.frame = CGRectMake(x, y, width, height);
    itemView.backgroundColor = [UIColor brownColor];
    if(index%2==0){
        [trip1 addSubview:itemView];
    }else{
        [trip2 addSubview:itemView];
    }
    [cellIsInViewTreeMap setObject:[NSNumber numberWithBool:YES] forKey:[NSNumber numberWithInt:index]];
}

-(void) dealloc{
    [view release];
    
    [scrollview release];
    [trip1 release];
    [trip2 release];
    
    [images release];
    [imagePos release];
    [imageViewsCache release];
    [cellIsInViewTreeMap release];
}
#pragma mark - UIScrollViewDelegate
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    [self check];
}

@end


















