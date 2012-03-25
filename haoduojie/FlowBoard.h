//
//  FlowBoard.h
//  haoduojie
//
//  Created by  on 12-3-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ImageFlower;
@interface FlowBoard : UIViewController

@property (nonatomic, retain) IBOutlet ImageFlower* flower;

-(void)loadFromURL:(NSString*)url withTitle:(NSString*)title;

@end
