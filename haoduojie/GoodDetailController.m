//
//  GoodDetailController.m
//  haoduojie
//
//  Created by  on 12-3-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GoodDetailController.h"
#import "ImageLoader.h"

@implementation GoodDetailController

@synthesize good;
@synthesize ownerHead;
@synthesize ownerName;
@synthesize goodName;
@synthesize goodImg;
@synthesize goodLikeNum;
@synthesize goodFrom;
@synthesize goodCommentList;
@synthesize price;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ownerName.text = good.ownerName;
    goodName.text = good.goodName;
    goodFrom.text = good.streetName;
    price.text = [[NSString alloc] initWithFormat:@"%.1f元",good.price ];
    NSLog(@"detail物品的名称: %@", good.goodName);
    NSLog(@"detail物品的图片地址: %@", good.goodImageLarge);
    
    
    [ImageLoader loadImageUsingSrc:good.goodImageLarge usingBlock:^(UIImage* image){
        goodImg.image = image;
    }];
    
    [ImageLoader loadImageUsingSrc:good.ownerHead usingBlock:^(UIImage* image){
        ownerHead.image = image;
    }];
}

- (void)viewDidUnload
{
    [self setOwnerName:nil];
    [self setOwnerHead:nil];
    [self setGoodName:nil];
    [self setGoodImg:nil];
    [self setGoodLikeNum:nil];
    [self setGoodFrom:nil];
    [self setGoodCommentList:nil];
    [self setPrice:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) viewWillAppear:(BOOL)animated{
    self.navigationController.navigationBarHidden = NO;
    
    [super viewWillAppear:animated];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [ownerName release];
    [ownerHead release];
    [ownerName release];
    [goodName release];
    [goodImg release];
    [goodLikeNum release];
    [goodFrom release];
    [goodCommentList release];
    [price release];
    [super dealloc];
}
@end
