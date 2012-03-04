//
//  DatePickerViewController.m
//  haoduojie
//
//  Created by  on 12-3-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "DatePickerViewController.h"

@implementation DatePickerViewController
@synthesize datePicker;

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
#pragma mark - actions
-(IBAction)buttonPressed{
    NSDate *seleted = [datePicker date];
    NSString *message = [[NSString alloc] initWithFormat:@"The date and time you selected is: %@", seleted];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Date and time seleted" message:message delegate:nil cancelButtonTitle:@"cancel" otherButtonTitles:@"other", nil];
    [alert show];
    [alert release];
    [message release];
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSDate *now = [[NSDate alloc] init];
    [datePicker setDate:now animated:YES];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    self.datePicker = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)dealloc{
    [datePicker release];
    [super dealloc];
}
@end
