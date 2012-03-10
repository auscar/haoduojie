//
//  PhotoFlowController.m
//  haoduojie
//
//  Created by  on 12-3-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "PhotoFlowController.h"

#import "MyFavStreetsViewController.h"
#import "MyStreetsViewController.h"

#define kTriggerOffSet 100.0f


@implementation UINavigationBar (CustomImage)
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"navigationBarBackgroundRetro.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end
@implementation UIToolbar (CustomImage)
- (void)drawRect:(CGRect)rect {
    UIImage *image = [UIImage imageNamed: @"navigationBarBackgroundRetro.png"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}
@end

@implementation PhotoFlowController
@synthesize myOwnStreets;
@synthesize myFavStreets;
@synthesize toolBar;
@synthesize bottomBoard;
@synthesize photoFlowBoard;



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



#pragma mark - View lifecycle
- (void)viewWillAppear:(BOOL)animated{
    self.tabBarController.navigationController.navigationBarHidden = YES;
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.bottomBoard addSubview:myOwnStreets.view];
    [self.bottomBoard addSubview:myFavStreets.view];
    //[self.view insertSubview:myFavStreets.view atIndex:1];
    //[self.view insertSubview:myOwnStreets.view atIndex:0];
    [self allHide];    
    
    //外观的一些定制logo啊之类的:
    
    UIImage *logoImg = [UIImage imageNamed:@"haoduojie-logo.png"];
    UIImageView *logoImgView = [[UIImageView alloc] initWithImage:logoImg];
    
    //navigationBar上的titleView
    UIView *titleView = [[UIView alloc] initWithFrame:CGRectMake(0,0,logoImg.size.width, logoImg.size.height)];
    
    [titleView addSubview:logoImgView];
    logoImgView.center = titleView.center;
    
    self.tabBarController.navigationItem.titleView = titleView;
    
    
    UIImage *logoImg2 = [UIImage imageNamed:@"haoduojie-logo.png"];
    UIImageView *toolBarLogoImgView = [[UIImageView alloc] initWithImage:logoImg2];
    toolBarLogoImgView.center = self.toolBar.center;
    [self.toolBar addSubview:toolBarLogoImgView];
    
    
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
    
    /*
    [shadow setShadowOffset:CGSizeMake(5, 5)];
    [shadow setShadowRadius:6];
    [shadow setShadowOpacity:1]; 
    [shadow setShadowColor:[UIColor blueColor].CGColor];
     */
    
    //bottomShadow.alpha = 0.6;
    
    [self.photoFlowBoard.layer addSublayer:shadow];
    [self.photoFlowBoard.layer insertSublayer:shadow2 atIndex:0];
    //[self.photoFlowBoard.layer addSublayer:shadow2];
    
}

- (void)viewDidUnload
{
    [self setMyOwnStreets:nil];
    [self setMyFavStreets:nil];
    [self setBottomBoard:nil];
    [self setPhotoFlowBoard:nil];
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


@end
