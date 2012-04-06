//
//  DiscoverController.m
//  haoduojie
//
//  Created by  on 12-3-2.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "DiscoverController.h"
#import "HTTP.h"
#import "Constants.h"
#import "SBJson.h"
#import "ImageLoader.h"
#import "DicoverTableCell.h"
#import "FlowBoard.h"
#import "DiscoverButton.h"

@implementation DiscoverController
@synthesize table;

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
    NSString* url = [[NSString alloc] initWithFormat:@"%@/street/discover", apiUri];
    
    //发请求获取封街道信息
    [HTTP loadUsingSrc:url usingBlock:^(ASIHTTPRequest* req){
        NSLog(@"###################>>>>>>返回 %@", [req responseString]);
        NSDictionary* obj = [[req responseString] JSONValue];
        
        streetInfos = [[NSArray alloc] initWithArray:[obj objectForKey:@"streets"]];
        
        [table reloadData];
    }];
}
-(void) viewWillAppear:(BOOL)animated{
    self.tabBarController.title = @"发现";
    self.tabBarController.navigationItem.leftBarButtonItem = nil;
    self.tabBarController.navigationItem.rightBarButtonItem = nil;
    
    [super viewWillAppear:animated];
}
- (void)viewDidUnload
{
    self.table = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) dealloc{
    [self.table release];
    [streetInfos release];
    [super dealloc];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}


-(void)buttonTap:(id)sender{
    DiscoverButton* btn = (DiscoverButton*)sender;
    
    FlowBoard* fb = [[FlowBoard alloc] init];    
    
    [self.navigationController pushViewController:fb animated:YES];
    //self.tabBarController.title = @"返回“发现”";
    self.navigationController.navigationItem.hidesBackButton = YES;
    
    NSLog(@" going to show flow of %d", btn.streetId);
    
    NSString* url = [[NSString alloc] initWithFormat:@"%@/street/%d/goodsList",apiUri,btn.streetId];
    
    [fb loadFromURL:url withTitle:btn.streetName];
}
#pragma mark - UITableView datasource
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
     NSLog(@"tableView height");
    return 96.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"tableView numberofrows");
    return (streetInfos.count)/3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"tableView cell");
    static NSString *CellIdentifier = @"discoverCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DiscoverCell" owner:self options:nil];
        if([nib count] > 0){
            NSLog(@"加载到xib");
            cell = [nib lastObject];
        }else{
            NSLog(@"faild to load custom xib");
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
	}
    
    DicoverTableCell* dcell = (DicoverTableCell*)cell;
    NSDictionary* info;
    
    for (int i=0; i<3; i++) {
        info = [streetInfos objectAtIndex:([indexPath row]*3+i)];
        
        if (i==0) {
            dcell.label1.text = [info objectForKey:@"streetName"];
            dcell.btn1.tag = [[info objectForKey:@"streetId"] intValue];
            [((DiscoverButton*)(dcell.btn1)) setStreetId:dcell.btn1.tag];
            [((DiscoverButton*)(dcell.btn1)) setStreetName:dcell.label1.text];
            [ImageLoader loadImageUsingSrc:[info objectForKey:@"cover"] usingBlock:^(UIImage *image){
                [dcell.btn1 setImage:image forState:UIControlStateNormal];
                [dcell.btn1 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            }];
        }else if(i==1){
            dcell.label2.text = [info objectForKey:@"streetName"];
            dcell.btn2.tag = [[info objectForKey:@"streetId"] intValue];
            [((DiscoverButton*)(dcell.btn2)) setStreetId:dcell.btn2.tag];
            [((DiscoverButton*)(dcell.btn2)) setStreetName:dcell.label2.text];
            [ImageLoader loadImageUsingSrc:[info objectForKey:@"cover"] usingBlock:^(UIImage *image){
                [dcell.btn2 setImage:image forState:UIControlStateNormal];
                [dcell.btn2 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            }];
            
        }else if(i==2){
            dcell.label3.text = [info objectForKey:@"streetName"];
            dcell.btn3.tag = [[info objectForKey:@"streetId"] intValue];
            [((DiscoverButton*)(dcell.btn3)) setStreetId:dcell.btn3.tag];
            [((DiscoverButton*)(dcell.btn3)) setStreetName:dcell.label3.text];
            [ImageLoader loadImageUsingSrc:[info objectForKey:@"cover"] usingBlock:^(UIImage *image){
                [dcell.btn3 setImage:image forState:UIControlStateNormal];
                [dcell.btn3 addTarget:self action:@selector(buttonTap:) forControlEvents:UIControlEventTouchUpInside];
            }];
        }
        
    }
    
	return cell;
}


@end




















