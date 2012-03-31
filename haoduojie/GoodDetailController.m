//
//  GoodDetailController.m
//  haoduojie
//
//  Created by  on 12-3-30.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import "SBJson.h"
#import "GoodDetailController.h"
#import "ImageLoader.h"
#import "HTTP.h"
#import "Constants.h"
#import "Tools.h"
#import "UICommentTableViewCell.h"


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
@synthesize commentTable;

#pragma mark - View UITableViewDelegate, UITableViewDataSource

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* info = [commentArray objectAtIndex:[indexPath row]];
    
    NSString *text = [info objectForKey:@"content"];
    
    CGFloat height = [Tools getText:text heightWithWidth:255 andWithFont:[UIFont systemFontOfSize:14.0f]];
     NSLog(@"height------->>>>>>>: %f", height);
    return height+38;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"tableView cell");
    static NSString *CellIdentifier = @"commentCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentTableViewCell" owner:self options:nil];
        if([nib count] > 0){
            NSLog(@"加载到xib");
            cell = [nib lastObject];
        }else{
            NSLog(@"faild to load custom xib");
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
    
    UICommentTableViewCell* tcell = (UICommentTableViewCell*)cell;
    NSDictionary* info = [commentArray objectAtIndex:[indexPath row]];
    
    tcell.ownerName.text = [info objectForKey:@"ownerName"];
    tcell.intime.text = [info objectForKey:@"intime"];
    tcell.content.text = [info objectForKey:@"content"];
    
    tcell.content.backgroundColor = [UIColor clearColor];
    
    CGFloat textHeight = [Tools getText:tcell.content.text heightWithWidth:255 andWithFont:[UIFont systemFontOfSize:14.0f]];
    [Tools view:tcell.content ScaleToHeight:(tcell.content.contentSize.height)];
    
    NSLog(@"contentHeight------->>>>>>>: %f", textHeight);
    
    [ImageLoader loadImageUsingSrc:[info objectForKey:@"ownerHead"] usingBlock:^(UIImage *image) {
        tcell.ownerHead.image = image;
    }];
    
    return tcell;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [commentArray count];
}



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
    
    NSString* detailUrl = [[NSString alloc] initWithFormat:@"%@/good/%d/details",apiUri,good.goodId];
    
    //获取details, 包括物品的评论和大图以及说明
    [HTTP loadUsingSrc:detailUrl usingBlock:^(ASIHTTPRequest *req){
        NSDictionary* obj = [[req responseString] JSONValue];
        
        commentArray = [[NSArray alloc] initWithArray:[obj objectForKey:@"comments"]];
        
        [commentTable reloadData];
        
        [Tools view:commentTable ScaleToHeight:commentTable.contentSize.height];
        
        [Tools scrollViewContentSizeVerticalFit:(UIScrollView*)self.view];

    }];
    
    
    
    
    
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
    [self setCommentTable:nil];
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
    [commentTable release];
    [super dealloc];
}
@end
