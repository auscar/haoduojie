//
//  MyFavStreetsViewController.m
//  haoduojie
//
//  Created by  on 12-3-6.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "MyFavStreetsViewController.h"
#import "ImageLoader.h"
#import "SBJson.h"
#import "Constants.h"
#import "ASIHTTPRequest.h"
@implementation MyFavStreetsViewController

@synthesize photoFlowController;

-(void) loadArray{
}


-(void) didFinishRequest:(ASIHTTPRequest *)req{
    NSLog(@"图片%@ 有返回",[req.url absoluteString]);
    NSLog(@"请求的状态码是%d", [req responseStatusCode] );
    NSLog(@"%@", [req responseString]);
    NSDictionary* obj = [[req responseString] JSONValue];
    //获取服务器返回的数据, 此时这些图片都还是只是一个url
    streetInfos = [[NSMutableArray alloc] initWithArray:[obj objectForKey:@"streets"]];
    NSLog(@"用户有%d条街道", [streetInfos count]);
}


-(void)request{
    NSLog(@"异步获用户关注的街道数据");
    NSURL *url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@/street/listFaivote",apiUri]];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
    req.delegate = self;
    req.didFinishSelector = @selector(didFinishRequest:);
    req.didFailSelector = @selector(didFailRequest:);
    [req startSynchronous];
}
-(void) loadArrayAction:(id)sender{
    [self request];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [self request];
    //初始化一下表格的宽度
    self.tableView.frame = CGRectMake(0, 0, 290, 416);
    
    
    //backgroud texture
    //UIImageView *bg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"jie-bg.png"]];
    //self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"jie-bg.png"]];
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
    NSDictionary* info = [streetInfos objectAtIndex:[indexPath row]];
    
    NSString* url = [[NSString alloc] initWithFormat:@"%@/street/%@/goodsList",apiUri, [info objectForKey:@"streetId"]];
    //photoFlow加载数据
    [photoFlowController loadFlowContentFrom:url];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [url release];
    
}

#pragma mark - UITableView datasource
/*
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return @"我关注的街道";
}
*/
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 111.0f;
}
 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [streetInfos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"favTableCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"StreetCell" owner:self options:nil];
        if([nib count] > 0){
            NSLog(@"加载到xib");
            cell = [nib lastObject];
        }else{
            NSLog(@"faild to load custom xib");
        }
        
        NSDictionary* info = [streetInfos objectAtIndex:[indexPath row]];
        ((UILabel*)[cell viewWithTag:2]).text = [info objectForKey:@"streetName"];
        ((UILabel*)[cell viewWithTag:4]).text = [info objectForKey:@"ownerName"];
        ((UILabel*)[cell viewWithTag:5]).text = [NSString stringWithFormat:@"%@个朋友",[info objectForKey:@"friendsNum"]];
        
        [ImageLoader loadImageUsingSrc:[info objectForKey:@"ownerHead"] usingBlock:^(UIImage *image){
            ((UIImageView*)[cell viewWithTag:3]).image = image;
        }];
        [ImageLoader loadImageUsingSrc:[info objectForKey:@"cover"] usingBlock:^(UIImage *image){
            [((UIButton*)[cell viewWithTag:1]) setImage:image forState:UIControlStateNormal];
        }];
        //cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
    
	return cell;
}
@end
