//
//  MyFavStreetsViewController.m
//  haoduojie
//
//  Created by  on 12-3-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyFavStreetsViewController.h"

@implementation MyFavStreetsViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    streetInfos = [[NSArray alloc] initWithObjects:@"fashion street", @"Wang Fujing Street",@"Tian Shangrenjie Street", nil];
    
    //初始化一下表格的宽度
    self.tableView.frame = CGRectMake(0, 0, 290, self.view.frame.size.height);
    
    //backgroud texture
    //UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jie-bg.png"]];
    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"jie-bg.png"]];
    //[self.view insertSubview:bg atIndex:0];
    //[self.view addSubview:bg];

    
    
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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



#pragma mark - UITableView delegate

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableView datasource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"我关注的街道";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [streetInfos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"LeftViewTableCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
    cell.textLabel.text = [streetInfos objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor whiteColor];
    
	return cell;
}

@end
