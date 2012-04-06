//
//  GoodPublishController.m
//  haoduojie
//
//  Created by  on 12-4-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import "ASIFormDataRequest.h"
#import "GoodPublishController.h"
#import "Tools.h"
#import "Constants.h"
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
-(void)reset:(id)sender{
    NSLog(@"reset~");
    
    //NSArray* keys = [infoFieldValue allKeys];
    
    NSArray* cells = [infoTable visibleCells];
    
    for (UITableViewCell* cell in cells) {
        NSLog(@"cell type: %@", [[cell class] description]);
        if ([cell isKindOfClass:[InfoEditTextFieldCell class]]) {
            ((InfoEditTextFieldCell*)cell).input.text = nil;
        }else{
            ((SwitchFieldTableViewCell*)cell).switchBtn.on = YES;
        }
    }
    
    //发布到微博默认为打开状态
    [infoFieldValue setObject:[NSNumber numberWithBool:YES] forKey:[NSNumber numberWithInt:4]];
}

-(void)onPostEnd{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    [_customStatusBar hide];
}
-(void)onPostSus{
    [self reset:nil];
    [self onPostEnd];
}
-(void)onPostFail{
    [self onPostEnd];
}
-(void)publish:(id)sender{
    NSLog(@"publish~");
    
    
    NSURL *url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@/good/publish", apiUri]];
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];
    
    
    //NSLog(@"the data sent are %@ %@ %@",email.text, nick.text, pwd.text);
    //NSData *imageData = UIImageJPEGRepresentation(self.head, 90);
    
    //[req addData:imageData withFileName:@"head.jpg" andContentType:@"image/jpeg" forKey:@"head"];
    [req addPostValue:title.text forKey:@"title"];
    [req addPostValue:desc.text forKey:@"desc"];
    [req addPostValue:price.text forKey:@"price"];
    [req addPostValue:to.text forKey:@"to"];
    [req addPostValue:(weibo.on?@"1":@"") forKey:@"weibo"];
    
    [_customStatusBar showWithStatusMessage:@"正在提交"];
    [req setCompletionBlock:^(void) {
        if ([req responseStatusCode] == 200) {//成功
            [_customStatusBar showWithStatusMessage:@"提交成功!"];
            [NSTimer scheduledTimerWithTimeInterval: 0.3
                                             target: self
                                           selector: @selector(onPostSus)
                                           userInfo: nil
                                            repeats: NO];            
        }else{//失败
            [_customStatusBar showWithStatusMessage:@"提交失败!"];
            [NSTimer scheduledTimerWithTimeInterval: 0.3
                                             target: self
                                           selector: @selector(onPostFail)
                                           userInfo: nil
                                            repeats: NO];
        }
    }];
    
    [req setDelegate:self];
    [req startAsynchronous];
    [url release];
    
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
        
        //获取他们的引用, 在提交的时候取他们的值来post到服务器
        switch (row) {
            case 0:
                title = icell.input;
                break;
            case 1:
                desc = icell.input;
                break;
            case 2:
                price = icell.input;
                break;
            case 3:
                to = icell.input;
                break;
            case 4:
                weibo = scell.switchBtn;
                break;
            default:
                break;
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
    NSLog(@"value changed");
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
    
    _customStatusBar = [[CustomStatusBar alloc] initWithFrame:CGRectZero];
    
    [self reset:nil];
    //[infoFieldValue setObject:[NSNumber numberWithBool:YES] forKey:[NSNumber numberWithInt:4]];
    
    
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







