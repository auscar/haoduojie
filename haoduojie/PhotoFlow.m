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

-(CGFloat) getHeight:(UIImage *)image withWidth:(CGFloat)width{
    if(!image)return 0.0f;
    
    CGFloat rate = image.size.height/image.size.width;
    
    return floor(width*rate);
    
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
    UIImage *p = [UIImage imageNamed:[photos objectAtIndex:indexPath.row]];
    return [self getHeight:p withWidth:151];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"photoFlowCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        UIImage *p = [UIImage imageNamed:[photos objectAtIndex:indexPath.row]];
        UIImageView *photo = [[UIImageView alloc] initWithImage:p];
        
        NSLog(@"height is:%f", [self getHeight:p withWidth:151]);
        photo.frame = CGRectMake(6, 0, 151, [self getHeight:p withWidth:151]);
        photo.tag = 5;
        [cell addSubview:photo];
	}
    NSLog(@"memory");

    cell.textLabel.text = [photos objectAtIndex:indexPath.row];
    
	return cell;
}

@end
