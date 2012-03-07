//
//  PhotoFlowController.m
//  haoduojie
//
//  Created by  on 12-3-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PhotoFlowController.h"

#import "MyFavStreetsViewController.h"
#import "MyStreetsViewController.h"


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

- (void)viewDidLoad
{
    [self.bottomBoard addSubview:myOwnStreets.view];
    [self.bottomBoard addSubview:myFavStreets.view];
    //[self.view insertSubview:myFavStreets.view atIndex:1];
    //[self.view insertSubview:myOwnStreets.view atIndex:0];
    [self allHide];    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
            //photoBoardIsOutOfStage = YES;
        }
     ];
}
-(void) slideBack{
    photoBoardIsOutOfStage = NO;
    [self slideTo:CGRectMake(0.0f, self.photoFlowBoard.frame.origin.y, self.photoFlowBoard.frame.size.width, self.photoFlowBoard.frame.size.height)];
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
