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
#import "CommentCell.h"
#import "CommentController.h"
#import "InfoScrollView.h"
#import "Detail.h"

@implementation GoodDetailController
@synthesize detailTable;
@synthesize infoPanel;
@synthesize good;
@synthesize ownerHead;
@synthesize ownerName;
@synthesize goodName;
@synthesize goodImg;
@synthesize goodLikeNum;
@synthesize goodFrom;
//@synthesize goodCommentList;
@synthesize price;
//@synthesize commentTable;

-(IBAction)leaveCommentTapped:(id)sender{
    CommentController* cc = [[CommentController alloc] init];
    cc.goodId = self.good.goodId;
    
    [self presentModalViewController:cc animated:YES];
}
/*

#pragma mark - InfoScrollViewDelegate
-(int)countOfItems{
    return [detailArray count];
}

-(int)widthOfEachItem{
    return 308;
}
-(int)heightOfEachItem{
    return 308;
}
-(int)paddingOfEachItem{
    return 6;
}
-(UIView*)viewForIndex:(int)index ofScrollView:(InfoScrollView *)scrollView{
    NSDictionary* detail = [detailArray objectAtIndex:index];
    UIView* dview = [scrollView getReusableViewIdentifiedBy:[NSNumber numberWithInt:index ]];
    if (dview == nil) {
        dview = [[UIImageView alloc] init];
        [ImageLoader loadImageUsingSrc:[detail objectForKey:@"image"] usingBlock:^(UIImage *image){
            ((UIImageView*)dview).image = image;
        }];
        [scrollView cacheView:dview withIdentifier:[NSNumber numberWithInt:index]];
    }
    return dview;
}
*/

#pragma mark - View UITableViewDelegate, UITableViewDataSource
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* info = [detailArray objectAtIndex:[indexPath row]];
    
    NSString *text = [info objectForKey:@"desc"];
    
    CGFloat height = [Tools getText:text heightWithWidth:320 andWithFont:[UIFont systemFontOfSize:14.0f]];
    return height+38+308;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"detailCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:nil];
        if([nib count] > 0){
            NSLog(@"加载到xib");
            cell = [nib lastObject];
        }else{
            NSLog(@"faild to load custom xib");
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
    
    Detail* tcell = (Detail*)cell;
    NSDictionary* info = [detailArray objectAtIndex:[indexPath row]];
    
    
    tcell.detailText.text = [info objectForKey:@"desc"];
    tcell.detailText.backgroundColor = [UIColor clearColor];
    
    
    [ImageLoader loadImageUsingSrc:[info objectForKey:@"image"] usingBlock:^(UIImage *image) {
        tcell.detailImage.image = image;
    }];
    
    return tcell;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [detailArray count];
}

#pragma mark - View UIScrollViewDelegate



#pragma mark - View lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
        
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    ownerName.text = good.ownerName;
    goodName.text = good.goodName;
    goodFrom.text = good.streetName;
    price.text = [[NSString alloc] initWithFormat:@"%.1f元",good.price ];
    
    [ImageLoader loadImageUsingSrc:good.ownerHead usingBlock:^(UIImage* image){
        ownerHead.image = image;
    }];
    
    NSString* detailUrl = [[NSString alloc] initWithFormat:@"%@/good/%d/details",apiUri,good.goodId];
    //发请求取details
    [HTTP loadUsingSrc:detailUrl usingBlock:^(ASIHTTPRequest *req){
        NSDictionary* obj = [[req responseString] JSONValue];
        detailArray = [[NSArray alloc] initWithArray:[obj objectForKey:@"details"]];
        NSLog(@"有%d个detail", [detailArray count]);
        
        [detailTable reloadData];
        
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
    [self setPrice:nil];
    leaveComment = nil;
    [self setDetailTable:nil];
    [self setInfoPanel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    /*
    [UIView beginAnimations: @"anim" context: nil];
    [self.navigationController.navigationBar setAlpha:1];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration:.5f];
    
    //progressBar.hidden = YES;
    [UIView commitAnimations];
     */

    
    //评论按钮
    UIBarButtonItem *rf = [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStyleBordered target:self action:@selector(leaveCommentTapped:)];
    self.navigationItem.rightBarButtonItem = rf;
    
    
    
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    [ownerName release];
    [ownerHead release];
    [ownerName release];
    [goodName release];
    [goodImg release];
    [goodLikeNum release];
    [goodFrom release];
    //[goodCommentList release];
    [price release];
    [commentTable release];
    [leaveComment release];
    [detailTable release];
    [infoPanel release];
    [super dealloc];
}
@end
