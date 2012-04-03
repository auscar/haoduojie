//
//  PhotoFlowController.m
//  haoduojie
//
//  Created by  on 12-3-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PhotoFlowController.h"

#import "Constants.h"
#import "MyFavStreetsViewController.h"
#import "MyStreetsViewController.h"
#import "GoodDetailController.h"
#import "PhotoFlow.h"
#import "ImageFlower.h"
#import "Good.h"

#define kTriggerOffSet 100.0f

//@class PhotoFlow;

@implementation PhotoFlowController
@synthesize myOwnStreets;
@synthesize myFavStreets;
@synthesize toolBar;
@synthesize bottomBoard;
@synthesize photoFlowBoard;
@synthesize table1;
@synthesize table2;
@synthesize pf1;
@synthesize pf2;
@synthesize flower;



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

-(void) allHide{
    self.myFavStreets.view.hidden = YES;
    self.myOwnStreets.view.hidden = YES;
}
-(void) showOwn{
    self.myFavStreets.view.hidden = YES;
    self.myOwnStreets.view.hidden = NO;
}
-(void) showFav{
    self.myFavStreets.view.hidden = NO;
    self.myOwnStreets.view.hidden = YES;
}
-(void)onDrag:(UIPanGestureRecognizer*)r{
    
    CGPoint p = [r locationInView:r.view];
    table1.contentOffset = CGPointMake(6, -p.y);
}


#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationController.navigationBarHidden = NO;
    /*
    [UIView beginAnimations: @"anim" context: nil];
    [self.navigationController.navigationBar setAlpha:0];
    [UIView setAnimationBeginsFromCurrentState: YES];
    [UIView setAnimationDuration:.5f];
     */
    
    //progressBar.hidden = YES;
    //[UIView commitAnimations];
    
    UIBarButtonItem *rf = [[UIBarButtonItem alloc] initWithTitle:@"我街" style:UIBarButtonItemStyleBordered target:self action:@selector(ownBtnTapped:)];
    self.tabBarController.navigationItem.rightBarButtonItem = rf;
    
    UIBarButtonItem *lf = [[UIBarButtonItem alloc] initWithTitle:@"关注" style:UIBarButtonItemStyleBordered target:self action:@selector(favBtnTapped:)];
    self.tabBarController.navigationItem.leftBarButtonItem = lf;
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    
    [self.bottomBoard addSubview:myOwnStreets.view];
    [self.bottomBoard addSubview:myFavStreets.view];
    [self allHide];    
    
    //阴影
    CGColorRef darkColor = [[UIColor blackColor] colorWithAlphaComponent:.3f].CGColor;  
    CGColorRef lightColor = [UIColor clearColor].CGColor;
    
    //shadow
    CAGradientLayer *shadow = [[[CAGradientLayer alloc] init] autorelease];  
    shadow.frame = CGRectMake(-10,0, 10, self.view.frame.size.height);  
    shadow.colors = [NSArray arrayWithObjects:(id)darkColor, (id)lightColor, nil];  
    //水平方向阴影
    shadow.startPoint = CGPointMake(1.0, 0.8);
    shadow.endPoint = CGPointMake(0.0, 0.8);
    shadow.opacity = 0.3f;
    
    //shadow2
    CAGradientLayer *shadow2 = [[[CAGradientLayer alloc] init] autorelease];  
    shadow2.frame = CGRectMake(self.view.frame.size.width,0, 10, self.view.frame.size.height);  
    shadow2.colors = [NSArray arrayWithObjects:(id)darkColor, (id)lightColor, nil];
    //水平方向阴影
    shadow2.startPoint = CGPointMake(0.0, 0.8);
    shadow2.endPoint = CGPointMake(1.0, 0.8);
    shadow2.opacity = 0.3f;
    
    //bottomShadow.alpha = 0.6;
    
    [self.photoFlowBoard.layer addSublayer:shadow];
    [self.photoFlowBoard.layer insertSublayer:shadow2 atIndex:0];
    //[self.photoFlowBoard.layer addSublayer:shadow2];
    
    NSString* url_pyh = [[NSString alloc] initWithFormat:@"%@/street/123/goodsList",apiUri];
    //发一个请求玩玩
    //[self loadFromURL:[[NSString alloc] initWithFormat:@"http://%@/street/123/goodsList",apiUri]];
    [flower loadFromURL:url_pyh];
    
    //传入photoFlowController, 当tableCell被点击的时候需要photoFlow完成一些操作
    [myFavStreets setPhotoFlowController:self];
    [myOwnStreets setPhotoFlowController:self];
    
}


- (void)viewDidUnload
{
    [self setMyOwnStreets:nil];
    [self setMyFavStreets:nil];
    [self setBottomBoard:nil];
    [self setPhotoFlowBoard:nil];
    [self setTable1:nil];
    [self setTable2:nil];
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
    [myOwnStreets release];
    [myFavStreets release];
    [bottomBoard release];
    [photoFlowBoard release];
    [table1 release];
    [table2 release];
    [flower release];
    [super dealloc];
}

#pragma mark - methods


-(void) slideTo:(CGRect)newRect{
    [UIView animateWithDuration:0.3
        animations: ^{
            self.photoFlowBoard.frame = newRect;
        }
        completion:^(BOOL finished){
            UIControl *overView = [[UIControl alloc] init];
            overView.tag = 20121221;
            overView.backgroundColor = [UIColor clearColor];
            overView.frame = self.photoFlowBoard.frame;
            [overView addTarget:self action:@selector(slideBack) forControlEvents:UIControlEventTouchDown];
            [[[UIApplication sharedApplication] keyWindow] addSubview:overView];
            [overView release];
        }
     ];
}
-(void) slideBack{
    photoBoardIsOutOfStage = NO;
    
    [UIView animateWithDuration:0.3
                     animations: ^{
                         self.photoFlowBoard.frame = CGRectMake(0.0f, self.photoFlowBoard.frame.origin.y, self.photoFlowBoard.frame.size.width, self.photoFlowBoard.frame.size.height);
                     }
                     completion:^(BOOL finished){
                         UIControl *overView = (UIControl *)[[[UIApplication sharedApplication] keyWindow] viewWithTag:20121221];
                         [overView removeFromSuperview];
                     }
     ];
    
    //[self slideTo:CGRectMake(0.0f, self.photoFlowBoard.frame.origin.y, self.photoFlowBoard.frame.size.width, self.photoFlowBoard.frame.size.height)];
}

-(void) slideToLeft{
    photoBoardIsOutOfStage = YES;
    [self showOwn];
    [self slideTo:CGRectMake(-290.0f, self.photoFlowBoard.frame.origin.y, self.photoFlowBoard.frame.size.width, self.photoFlowBoard.frame.size.height)];
}
-(void) slideToRight{
    photoBoardIsOutOfStage = YES;
    [self showFav];
    [self slideTo:CGRectMake(290.0f, self.photoFlowBoard.frame.origin.y, self.photoFlowBoard.frame.size.width, self.photoFlowBoard.frame.size.height)];
}


// Check touch position in this method (Add by Ethan, 2011-11-27)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch=[touches anyObject];
    touchBeganPoint = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
}

// Scale or move select view when touch moved (Add by Ethan, 2011-11-27)
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:[[UIApplication sharedApplication] keyWindow]];
    
    CGFloat xOffSet = touchPoint.x - touchBeganPoint.x;
    
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (xOffSet < 0) {
        //[self slideBack];
        [self showOwn];
        //[appDelegate makeRightViewVisible];
    }
    else if (xOffSet > 0) {
        [self showFav];
        //[appDelegate makeLeftViewVisible];
    }
    
    self.photoFlowBoard.frame = CGRectMake(xOffSet, 
                                                      self.photoFlowBoard.frame.origin.y, 
                                                      self.photoFlowBoard.frame.size.width, 
                                                      self.photoFlowBoard.frame.size.height);
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    // animate to left side
    if (self.photoFlowBoard.frame.origin.x < -kTriggerOffSet) 
        [self slideToLeft];
    // animate to right side
    else if (self.photoFlowBoard.frame.origin.x > kTriggerOffSet) 
        [self slideToRight];
    // reset
    else 
        [self slideBack];
}

#pragma mark - actions
- (IBAction)ownBtnTapped:(id)sender{
    if (photoBoardIsOutOfStage) {
        [self slideBack];
    }else{
        [self slideToLeft];
    }
}

- (IBAction)favBtnTapped:(id)sender{
    if (photoBoardIsOutOfStage) {
        [self slideBack];
    }else{
        [self slideToRight];
    }
}

-(void)loadFlowContentFrom:(NSString *)url{
    //首先slideback
    [self slideBack];
    
    //然后flower加载url的数据
    [self.flower loadFromURL:url];
}
-(void)loadFlowContentFrom:(NSString *)url withTitle:(NSString *)title{
    [self loadFlowContentFrom:url];
}


#pragma mark - delegate
-(void) scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollview scroll...");
}

#pragma mark - ImageFlowerDelegate
-(void) imageFlower:(ImageFlower *)flower flowerCellDidTappedWithTarget:(id)target{
    Good* good = (Good*)target;
    
    //展示物品详细
    GoodDetailController* goodDetail = [GoodDetailController alloc];
    [goodDetail setGood:good];
    [goodDetail init];
    
    goodDetail.title = good.goodName;
     
    [self.navigationController pushViewController:goodDetail animated:YES];
    
}

@end
