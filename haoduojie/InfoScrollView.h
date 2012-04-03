//
//  InfoScrollView.h
//  haoduojie
//
//  Created by  on 12-4-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "InfoScrollViewDelegate.h"

@interface InfoScrollView : UIScrollView{
    id<InfoScrollViewDelegate> infoScrollViewDelegate;
    
    NSMutableDictionary* itemResueMap;
    UIPageControl *pageControl;
}
@property (nonatomic, retain) IBOutlet id infoScrollViewDelegate;

-(void)loadData;
-(UIView*)getReusableViewIdentifiedBy:(id)identifier;
-(void)cacheView:(UIView*)view withIdentifier:(id)identifier;
@property (retain, nonatomic) IBOutlet UIPageControl *pageControl;

@end