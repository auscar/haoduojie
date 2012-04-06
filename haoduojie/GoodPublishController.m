//
//  GoodPublishController.m
//  haoduojie
//
//  Created by  on 12-4-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "GoodPublishController.h"
#import "Tools.h"
#import "InfoEditTextFieldCell.h"
#import "SwitchFieldTableViewCell.h"


@implementation GoodPublishController
@synthesize infoTable;
@synthesize photoScrollView;
@synthesize good;


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



#pragma mark - actions
-(void)publish:(id)sender{
    NSLog(@"publish~");
}
-(void)reset:(id)sender{
    NSLog(@"reset~");
    UITableViewCell* cell;
    UITextField* tf;
    UISwitch* sw;
    
    NSArray* keys = [infoFieldValue allKeys];

    NSIndexPath* indexPath;
    for (NSNumber* num in keys) {
        indexPath = [NSIndexPath indexPathWithIndex:[num intValue]];
        cell = [infoTable cellForRowAtIndexPath:indexPath];
        if ([num intValue]<4) {
            sw = (UISwitch*)[cell viewWithTag:2];
            sw.on = YES;
        }else{
            tf  = (UITextField*)[cell viewWithTag:2];
            tf.text = nil;
        }
        [indexPath release];
    }
}



#pragma mark - InfoScrollViewDelegate
-(int)countOfItems{
    //return [detailArray count];
    return 0;
}
 
-(int)widthOfEachItem{
    return 308;
}
-(int)heightOfEachItem{
    return 308;
}
-(int)paddingOfEachItem{
    return 6;
}
-(UIView*)viewForIndex:(int)index ofScrollView:(InfoScrollView *)scrollView{
    return nil;
}

#pragma mark - View UITableViewDelegate, UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [infoArray count];
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 45;
}
-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 48;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"InfoEditTextFieldCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    InfoEditTextFieldCell* icell;
    SwitchFieldTableViewCell* scell;
    int row = [indexPath row];
    if (cell == nil) {
        NSArray *nib;
        if (row == 4) {//boolean
            nib = [[NSBundle mainBundle] loadNibNamed:@"SwitchTableViewCell" owner:self options:nil];
        }else{
            nib = [[NSBundle mainBundle] loadNibNamed:@"TextFieldTableView" owner:self options:nil];
        }
        
        if([nib count] > 0){
            NSLog(@"加载到xib");
            cell = [nib lastObject];
        }else{
            NSLog(@"faild to load custom xib");
        }
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        
        if (row == 4) {//boolean
            scell = (SwitchFieldTableViewCell*)cell;
            scell.label.text = [infoArray objectAtIndex:row];
            scell.switchBtn.on = YES;
            [scell.switchBtn addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
            scell.switchBtn.tag = row;
        }else{
            icell = (InfoEditTextFieldCell*)cell;
            icell.label.text = [infoArray objectAtIndex:row];
            icell.input.delegate = self;
            icell.input.tag = row;
        }
	}
    NSNumber* numb = [NSNumber numberWithInt:row];
    if ([infoFieldValue objectForKey:numb]) {
        if (row == 4) {//boolean
            scell.switchBtn.on = [[infoFieldValue objectForKey:numb] boolValue];
        }else{
            icell.input.text = [infoFieldValue objectForKey:numb];
        }
    }
    
    return cell;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    controlEditing = textField;
    if (!tap) {
        tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyBoardMiss)];
        [infoTable addGestureRecognizer:tap];
        [tap release];
    }
}
-(void)textFieldDidEndEditing:(UITextField *)textField{
    //记录下用户设置的值
    [infoFieldValue setObject:textField.text forKey:[NSNumber numberWithInt:textField.tag]];
}
-(void)switchValueChanged:(id)sender{
    UISwitch* switchBtn = (UISwitch*)sender;
    [infoFieldValue setObject:[NSNumber numberWithBool:switchBtn.on] forKey:[NSNumber numberWithInt:switchBtn.tag]];
    
}
-(void)keyBoardMiss{
    [controlEditing resignFirstResponder];
    controlEditing = nil;
    tap = nil;
    [infoTable removeGestureRecognizer:tap];
}
#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    infoArray = [[NSArray alloc] initWithObjects:@"标题",@"描述",@"价格",@"发布到",@"发布到微博", nil];
    infoFieldName = [[NSArray alloc] initWithObjects:@"title",@"desc",@"price",@"to",@"weibo", nil];
    infoFieldValue = [[NSMutableDictionary alloc] init];
    
    
    [infoTable reloadData];
}

- (void)viewDidUnload
{
    [self setInfoTable:nil];
    infoArray = nil;
    [self setPhotoScrollView:nil];
    infoTable = nil;
    infoArray = nil;
    infoFieldName = nil;
    infoFieldValue = nil;
    photoScrollView = nil;
    tap = nil;
    [super viewDidUnload];
    
    
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.tabBarController.title = @"发布好东西";
    
    UIBarButtonItem *rf = [[UIBarButtonItem alloc] initWithTitle:@"发布" style:UIBarButtonItemStyleBordered target:self action:@selector(publish:)];
    self.tabBarController.navigationItem.rightBarButtonItem = rf;
    
    UIBarButtonItem *lf = [[UIBarButtonItem alloc] initWithTitle:@"重置" style:UIBarButtonItemStyleBordered target:self action:@selector(reset:)];
    self.tabBarController.navigationItem.leftBarButtonItem = lf;
    
    [rf release];
    
    //self.tabBarController.navigationItem.leftBarButtonItem = nil;
     
    [super viewWillAppear:animated];
}
- (void)dealloc {
    [infoTable release];
    [infoArray release];
    [infoFieldName release];
    [infoFieldValue release];
    [photoScrollView release];
    [super dealloc];
}
@end







