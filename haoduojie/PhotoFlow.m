//
//  PhotoFlow.m
//  haoduojie
//
//  Created by  on 12-3-11.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "PhotoFlow.h"

@implementation PhotoFlow
@synthesize photos;
- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

#pragma mark - UITableView delegate

// Called after the user changes the selection.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - UITableView datasource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [photos count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //UIImageView *photo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"x_large_1wYX_61f900001d331262.jpg"]];
    return 186;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"photoFlowCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        UIImageView *photo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[photos objectAtIndex:indexPath.row]]];
        photo.frame = CGRectMake(6, 0, 151, 180);
        photo.tag = 5;
        [cell addSubview:photo];
	}

    cell.textLabel.text = [photos objectAtIndex:indexPath.row];
    //cell.textLabel.textColor = [UIColor whiteColor];
    
	return cell;
}

@end
