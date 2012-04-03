//
//  CommentController.m
//  haoduojie
//
//  Created by  on 12-4-1.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"
#import "CommentController.h"
#import "ButtonHelper.h"
#import "Constants.h"
#import "ASIFormDataRequest.h"
#import "HTTP.h"
#import "CommentCell.h"
#import "Tools.h"
#import "ImageLoader.h"



@implementation CommentController
@synthesize commentTextView;
@synthesize commentTable;
@synthesize goodId;
@synthesize good;
@synthesize scrollView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


-(void)loadComment{
    NSString* detailUrl = [[NSString alloc] initWithFormat:@"%@/good/%d/comments",apiUri,goodId];
    
    //获取details, 包括物品的评论和大图以及说明
    [HTTP loadUsingSrc:detailUrl usingBlock:^(ASIHTTPRequest *req){
        NSDictionary* obj = [[req responseString] JSONValue];
        
        commentArray = [[NSArray alloc] initWithArray:[obj objectForKey:@"comments"]];
        
        //NSLog(@"===================获得的评论列表有%d条评论================",[commentArray count]);
        
        [commentTable reloadData];
        
        [Tools view:commentTable ScaleToHeight:commentTable.contentSize.height];
        [Tools scrollViewContentSizeVerticalFit:scrollView];
        [Tools scrollView:scrollView contentSizeVerticalFitWithDerta:18];
        
        //[Tools view:scrollView ScaleToHeight:commentTable.contentSize.height+100];
        
    }];
}
-(void)onPostEnd{
    [_customStatusBar hide];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}
-(void)onPostSus{
    commentTextView.text = nil;
    [self onPostEnd];
    [self loadComment];
}

-(IBAction) back{
    [self onPostEnd];
    [self dismissModalViewControllerAnimated:YES];
}
-(IBAction)onBodyTapped:(id)sender{
    NSLog(@"bodddddddddddddyyyyy tapped.....");
    [commentTextView resignFirstResponder];
}
static inline BOOL isEmpty(id thing) {
    return thing == nil
    || ([thing respondsToSelector:@selector(length)]
        && [(NSData *)thing length] == 0)
    || ([thing respondsToSelector:@selector(count)]
        && [(NSArray *)thing count] == 0);
}
-(IBAction)commentPost:(id)sender{
    if (isEmpty(commentTextView.text)) {
        return;
    }
    
    NSString* url = [[NSString alloc] initWithFormat:@"%@/good/%d/commentPost",apiUri,goodId];
    NSLog(@"评论发往: %@", url);
    NSURL *uri = [[NSURL alloc] initWithString:url];
    ASIFormDataRequest *req =  [ASIFormDataRequest requestWithURL:uri];
    
    [req addPostValue:commentTextView.text forKey:@"content"];
    
    
    [_customStatusBar showWithStatusMessage:@"正在发送..."];
    
    [req setCompletionBlock:^{
        [_customStatusBar showWithStatusMessage:@"发送成功..."];
        [NSTimer scheduledTimerWithTimeInterval: 0.5
                                                 target: self
                                               selector: @selector(onPostSus)
                                               userInfo: nil
                                                repeats: NO];
    }];
    
    [req setFailedBlock:^(void){
        [_customStatusBar showWithStatusMessage:@"发送失败..."];
        [NSTimer scheduledTimerWithTimeInterval: 0.5
                                         target: self
                                       selector: @selector(onPostEnd)
                                       userInfo: nil
                                        repeats: NO];
    }];
    [req startAsynchronous];
    
}
#pragma mark - View UITableViewDelegate, UITableViewDataSource
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary* info = [commentArray objectAtIndex:[indexPath row]];
    
    NSString *text = [info objectForKey:@"content"];
    
    CGFloat height = [Tools getText:text heightWithWidth:255 andWithFont:[UIFont systemFontOfSize:14.0f]];
    return height+38;
}

-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"tableView cell");
    static NSString *CellIdentifier = @"commentCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CommentCell" owner:self options:nil];
        if([nib count] > 0){
            NSLog(@"加载到xib");
            cell = [nib lastObject];
        }else{
            NSLog(@"faild to load custom xib");
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
    
    CommentCell* tcell = (CommentCell*)cell;
    NSDictionary* info = [commentArray objectAtIndex:[indexPath row]];
    
    //NSLog(@"渲染第%d的content是%@", [indexPath row],[info objectForKey:@"content"]);
    
    tcell.commentContent.text = [info objectForKey:@"content"];
    tcell.ownerName.text = [info objectForKey:@"ownerName"];
    tcell.intime.text = [info objectForKey:@"intime"];
    
    tcell.commentContent.backgroundColor = [UIColor clearColor];
    
    
    
    [ImageLoader loadImageUsingSrc:[info objectForKey:@"ownerHead"] usingBlock:^(UIImage *image) {
        tcell.ownerHead.image = image;
    }];
    
    return tcell;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [commentArray count];
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UISegmentedControl *btn = [ButtonHelper makeSigmentButtonWithTitle:@"发送"];
    [btn setFrame:CGRectMake(6, 157, 80, 34)];
    [btn addTarget:self action:@selector(commentPost:) forControlEvents:UIControlEventValueChanged];
    [self.scrollView addSubview:btn];
    
    //圆角
    [self.commentTextView.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [self.commentTextView.layer setBorderWidth:1.0f];
    [self.commentTextView.layer setCornerRadius:5.0f];
    
    //[btn release];
    
    //自定义statusbar
    _customStatusBar = [[CustomStatusBar alloc] initWithFrame:CGRectZero];
}
-(void)viewWillAppear:(BOOL)animated{
    //[commentTextView becomeFirstResponder];
    [super viewWillAppear:animated];
    [self.view becomeFirstResponder];
    [self loadComment];
    
   
}
- (void)viewDidUnload
{
    [self setCommentTextView:nil];
    [self setCommentTable:nil];
    [self setScrollView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [commentTextView release];
    [commentTable release];
    [scrollView release];
    [super dealloc];
}
-(BOOL)canBecomeFirstResponder{
    return YES;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}
@end
