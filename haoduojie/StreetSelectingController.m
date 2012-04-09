//
//  StreetSelectingController.m
//  haoduojie
//
//  Created by  on 12-4-8.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ASIHTTPRequest.h"
#import "SBJson.h"

#import "Constants.h"
#import "StreetSelectingController.h"
#import "Dialog.h"
#import "Street.h"

@implementation StreetSelectingController
@synthesize toStreets;
@synthesize allMyStreets;

-(void)dealloc{
    [alert release];
    [toStreets release];
    [selectedCells release];
    [super dealloc];
}
- (void)viewDidUnload
{
    alert = nil;
    toStreets = nil;
    selectedCells = nil;
    [super viewDidUnload];
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
-(void)request{
    
    NSLog(@"异步获用户关注的街道数据");
    NSString* url = [[NSString alloc] initWithFormat:@"%@/street/listMy",apiUri];
    NSURL *uri = [[NSURL alloc] initWithString:url];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:uri];

     NSLog(@"异步获用户关注的街道数据 %@", url);
    [req setCompletionBlock:^(void) {
        NSDictionary* obj;
        NSArray* streets;
        BOOL sus = YES;
        NSString* msg;
        
        NSLog(@"response.string============>>>>>>>>>>>>>>%@", [req responseString]);
        
        if ([req responseStatusCode] == 200) {
            @try {
                obj = [req.responseString JSONValue];
                int code = [[obj objectForKey:@"code"] intValue];
                if (code) {
                    sus = NO;
                    msg = [obj objectForKey:@"msg"];
                }
            }
            @catch (NSException *exception) {
                sus = NO;
            }
        }else{
            sus = NO;
            msg = @"获取街道列表失败";
        }
        
        //清除并回收之前的内存空间
        if (allMyStreets) {
            [allMyStreets release];
            allMyStreets = nil;
        }
        allMyStreets = [[NSMutableArray alloc] init];
        
        if (sus) {//成功了就去获取列街道列表
            streets = [[NSArray alloc] initWithArray:[obj objectForKey:@"streets"]];
            NSLog(@"来自服务器%d条街道", [streets count]);
            Street* street;
            for (NSDictionary* s in streets) {
                street = [[Street alloc] init];
                street.streetId = [[s objectForKey:@"streetId"] intValue];
                street.streetName = [s objectForKey:@"streetName"];
                [allMyStreets addObject:street];
                //[street release];
                //street = nil;
            }
            NSLog(@"用户有条%d街道", [allMyStreets count]);
            [((UITableView*)self.view) reloadData];
        }else{
            if (alert) {
                [alert release];
                alert = nil;
            }
            alert = [Dialog alertWithTitle:@"提示" withMessage:msg withConfirmText:ALERT_CONFIRM withDelegate:self];
        }
    }];
    [req startAsynchronous];
}
-(void)ok:(id)sender{
    NSLog(@"ok");
    
    //将结果集给清空, 以便装新的结果集
    [toStreets removeAllObjects];
    
    
    NSLog(@"装箱前toStreests的长度 %d", [toStreets count]);
    
    //获取所有选中的streets
    NSArray* selectedIndex = [selectedCells allKeys];
    
    //NSLog(@"选中%d条街道", [selectedIndex count]);
    
    //通过这堆key获取具体选中的streets数据
    for (NSNumber* num in selectedIndex) {
        //if ([selectedCells objectForKey:num]) {
        [toStreets addObject:[allMyStreets objectAtIndex:num.intValue]];
        //}
    }
    
    NSLog(@"toStreets有%d条街道", [toStreets count]);
    
    for (Street* street in toStreets) {
        NSLog(@"已经选中的街道信息: id:%d  name:%@", street.streetId,street.streetName);
    }
    if ([toStreets count]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    selectedCells = [[NSMutableDictionary alloc] init];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    UIBarButtonItem *rf = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleBordered target:self action:@selector(ok:)];
    self.navigationItem.rightBarButtonItem = rf;
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //[rf release];
    
    //[((UITableView*)self.view) setEditing:YES animated:YES];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //发请求获取用户的街道信息
    [self request];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [allMyStreets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"渲染cell");
    static NSString *CellIdentifier = @"myStreetsCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
        //[cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    // Configure the cell...
    Street* street = [allMyStreets objectAtIndex:[indexPath row]];
    
    cell.textLabel.text = street.streetName;
    
    
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber* row = [NSNumber numberWithInt:[indexPath row]];
    //如果这个cell被选上了, 就取消它的选择
    if ([selectedCells objectForKey:row]) {
        [[selectedCells objectForKey:row] setAccessoryType:UITableViewCellAccessoryNone];
        [selectedCells removeObjectForKey:row];
        //[selectedCells setObject:nil forKey:row];
    }else{
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        [selectedCells setObject:cell forKey:row];
    }
    
    //[tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:nil];
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
/*
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete | UITableViewCellEditingStyleInsert;
}
 */
@end






















