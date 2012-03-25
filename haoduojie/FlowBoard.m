//
//  FlowBoard.m
//  haoduojie
//
//  Created by  on 12-3-23.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "FlowBoard.h"
#import "Constants.h"

@implementation FlowBoard
@synthesize flower;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        
    }
    return self;
}

-(void)loadFromURL:(NSString *)url withTitle:(NSString *)title{
    NSLog(@"让flowBoard加载%@", url);
    //[flower loadFromURL:[[NSString alloc] initWithFormat:@"%@/street/123/goodsList"]];
    [flower loadFromURL:url];
    
    self.title = title;
    
    [url release];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
-(void)viewWillAppear:(BOOL)animated{
    //self.title = @"dddd";
    
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
