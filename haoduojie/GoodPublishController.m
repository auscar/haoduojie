//
//  GoodPublishController.m
//  haoduojie
//
//  Created by  on 12-4-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "SBJson.h"
#import "ASIFormDataRequest.h"
#import "GoodPublishController.h"
#import "Tools.h"
#import "Constants.h"
#import "InfoEditTextFieldCell.h"
#import "SwitchFieldTableViewCell.h"
#import "PriceTableViewCell.h"
#import "InfoScrollView.h"
#import "PhotoHelper.h"
#import "Dialog.h"
#import "StreetSelectingController.h"
#import "WBEngine.h"




@implementation GoodPublishController
@synthesize infoTable;
//@synthesize photoScrollView;
@synthesize good;
@synthesize uploadScrollView;

- (void)dealloc {
    [infoTable release];
    [infoArray release];
    [infoFieldName release];
    [infoFieldValue release];
    [photoScrollView release];
    [uploadScrollView release];
    [alert release];
    [toStreets release];
    [super dealloc];
}
- (void)viewDidUnload
{
    NSLog(@"pubish unload");
    [self setInfoTable:nil];
    infoArray = nil;
    infoTable = nil;
    infoArray = nil;
    infoFieldName = nil;
    infoFieldValue = nil;
    photoScrollView = nil;
    tap = nil;
    [self setUploadScrollView:nil];
    alert = nil;
    [super viewDidUnload];
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



#pragma mark - actions and helper method
-(void)reset:(id)sender{
    NSLog(@"reset~");
    
    //NSArray* keys = [infoFieldValue allKeys];
    
    NSArray* cells = [infoTable visibleCells];
    
    for (UITableViewCell* cell in cells) {
        NSLog(@"cell type: %@", [[cell class] description]);
        if ([cell isKindOfClass:[InfoEditTextFieldCell class]]) {
            ((InfoEditTextFieldCell*)cell).input.text = nil;
        }else if([cell isKindOfClass:[PriceTableViewCell class]]){
            ((PriceTableViewCell*)cell).priceSwitchBtn.on = YES;
            ((PriceTableViewCell*)cell).price.text = nil;
        }
        else{
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
-(NSString*)getToStreetsString:(BOOL)isName{
    if ([toStreets count]) {
        NSMutableString* str = [[[NSMutableString alloc] init] autorelease];
        Street* street;
        for (int i=0; i<[toStreets count]; i++) {
            street = [toStreets objectAtIndex:i];
            if (i) {
                if (isName) {
                    [str appendFormat:@",%@",street.streetName];
                }else{
                    [str appendFormat:@",%d",street.streetId];
                }
                
            }else{
                if (isName) {
                    [str appendString:street.streetName];
                }else{
                    [str appendFormat:@"%d",street.streetId];
                }
            }
        }
        return str;
    }
    return nil;
}
-(void)publish:(id)sender{
    NSLog(@"publish~");
    
    if (alert) {
        [alert release];
        alert = nil;
    }
    //校验一下空提交
    if ([title.text isEqualToString:@""]) {
        alert = [Dialog alertWithTitle:ALERT_TITLE withMessage:ALERT_TIP_EMPTY_TITLE withConfirmText:ALERT_CONFIRM withDelegate:self];
        return;
    }else if([desc.text isEqualToString:@""]){
        alert = [Dialog alertWithTitle:ALERT_TITLE withMessage:ALERT_TIP_EMPTY_DESC withConfirmText:ALERT_CONFIRM withDelegate:self];
        return;
    }else if([price.text isEqualToString:@""]&&priceSwitch.on){
        alert = [Dialog alertWithTitle:ALERT_TITLE withMessage:ALERT_TIP_EMPTY_PRICE withConfirmText:ALERT_CONFIRM withDelegate:self];
        return;
    }else if([to.text isEqualToString:@""]){
        alert = [Dialog alertWithTitle:ALERT_TITLE withMessage:ALERT_TIP_EMPTY_TO withConfirmText:ALERT_CONFIRM withDelegate:self];
        return;
    }
    
    NSURL *url = [[NSURL alloc] initWithString:[[NSString alloc] initWithFormat:@"%@/good/publish", apiUri]];
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];
    
    
    //[req addData:imageData withFileName:@"head.jpg" andContentType:@"image/jpeg" forKey:@"head"];
    [req addPostValue:title.text forKey:@"title"];
    [req addPostValue:desc.text forKey:@"desc"];
    [req addPostValue:(priceSwitch.on?price.text:@"0") forKey:@"price"];
    [req addPostValue:(weibo.on?@"1":@"") forKey:@"weibo"];
    //发布到的街道
    [req addPostValue:[self getToStreetsString:NO] forKey:@"to"];
    
    //如果有图片则在请求中添加图片
    NSArray* keys = [photosTaken allKeys];
    NSData *imageData;
    for (UIButton* btn in keys) {
        NSLog(@"往请求中添加一张照片");
        imageData = UIImageJPEGRepresentation([photosTaken objectForKey:btn], 90);
        [req addData:imageData withFileName:@"head.jpg" andContentType:@"image/jpeg" forKey:@"head"];
    }
    
    
    [_customStatusBar showWithStatusMessage:@"正在提交"];
    
    [req setCompletionBlock:^(void) {
        BOOL sus = YES;
        NSDictionary* obj;
        NSString* msg;
    
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
            msg = COMMIT_FAILD;
        }
        
       
        NSLog(@"服务器返回是=======>>>>>>>>>  %@",[req responseString]);
        if (sus) {//成功
            [_customStatusBar showWithStatusMessage:COMMIT_SUS];
            [NSTimer scheduledTimerWithTimeInterval: 0.3
                                             target: self
                                           selector: @selector(onPostSus)
                                           userInfo: nil
                                            repeats: NO];            
        }else{//失败
            [_customStatusBar showWithStatusMessage:COMMIT_FAILD];
            if (alert) {
                [alert release];
                alert = nil;
            }
            alert = [Dialog alertWithTitle:ALERT_TITLE withMessage:msg withConfirmText:ALERT_CONFIRM withDelegate:self];
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
-(void)takePicture:(id)sender{
    buttonTapForTakingPhoto = (UIButton*)sender;
    [PhotoHelper getMediaFromSource:UIImagePickerControllerSourceTypeCamera withDelegate:self];
}




#pragma mark - InfoScrollViewDelegate
-(int)countOfItems{
    return 6;
}
 
-(int)widthOfEachItem{
    return 96;
}
-(int)heightOfEachItem{
    return 96;
}
-(int)paddingOfEachItem{
    return 8;
}
-(UIView*)viewForIndex:(int)index ofScrollView:(InfoScrollView *)scrollView{
    UIButton* photoBtn = [[UIButton alloc] init];
    UIImage* img = [UIImage imageNamed:@"168-upload-photo-2.png"];
    [photoBtn setImage:img forState:UIControlStateNormal];
    [photoBtn setContentMode:UIViewContentModeCenter];
    photoBtn.backgroundColor = [UIColor colorWithRed:100 green:100 blue:100 alpha:0.5];
    photoBtn.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    photoBtn.layer.borderWidth = 1.0f;

    [photoBtn addTarget:self action:@selector(takePicture:) forControlEvents:UIControlEventTouchUpInside];
    [img release];   
    photoBtn.tag = index;
    return photoBtn;
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
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
    NSLog(@"did select...");
    if (tap) {
        [infoTable removeGestureRecognizer:tap];
        tap = nil;
    }
    if (indexPath.row == 3) {
        NSLog(@"push view please...");
        [tableView deselectRowAtIndexPath:indexPath animated:YES];    
        StreetSelectingController* ss = [StreetSelectingController alloc];
        ss.toStreets = toStreets;//将用户已经选择的街道传进去, 以便在街道列表中确认那些街道被选择了
        [ss init];
        
        [self.navigationController pushViewController:ss animated:YES];
    }else{
        [tableView deselectRowAtIndexPath:indexPath animated:NO];
    }
    
}
-(UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *CellIdentifier = @"InfoEditTextFieldCell";
	UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    InfoEditTextFieldCell* icell;
    SwitchFieldTableViewCell* scell;
    PriceTableViewCell* pcell;

    
    int row = [indexPath row];
    if (cell == nil) {
        NSArray *nib;
        if (row == 4) {//boolean
            nib = [[NSBundle mainBundle] loadNibNamed:@"SwitchTableViewCell" owner:self options:nil];
        }else if(row == 2){
            nib = [[NSBundle mainBundle] loadNibNamed:@"PriceTableViewCell" owner:self options:nil];
        }
        else{
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
        }else if(row == 2){
            pcell = (PriceTableViewCell*)cell;
            pcell.label.text = [infoArray objectAtIndex:row];
            pcell.price.delegate = self;
            pcell.priceSwitchBtn.on = YES;
            [pcell.priceSwitchBtn addTarget:self action:@selector(switchValueChanged2:) forControlEvents:UIControlEventValueChanged];

        }
        else{
            
            icell = (InfoEditTextFieldCell*)cell;
            icell.label.text = [infoArray objectAtIndex:row];
            icell.input.delegate = self;
            icell.input.tag = row;
            
            //选择街道
            if (row == 3) {
                [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
                [cell setSelectionStyle:UITableViewCellSelectionStyleBlue];
                icell.input.userInteractionEnabled = NO;
            }
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
                price = pcell.price;
                priceSwitch = pcell.priceSwitchBtn;
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
    
    //TODO: not work
    [((UIScrollView*)self.view) scrollRectToVisible:textField.frame animated:YES];
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
-(void)switchValueChanged2:(id)sender{
    NSLog(@"value changed2");
    UISwitch* switchBtn = (UISwitch*)sender;
    
    if (switchBtn.on) {
        [price setHidden:NO];
    }else{
        [price setHidden:YES];
    }

    
}
-(void)keyBoardMiss{
    NSLog(@"keyboard miss");
    [controlEditing resignFirstResponder];
    controlEditing = nil;
    if (tap) {
        [infoTable removeGestureRecognizer:tap];
        tap = nil;
    }
}
#pragma mark - ImagePickerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    
    // 保存原图到相册中   
    UIImageWriteToSavedPhotosAlbum( img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //预览
    if (buttonTapForTakingPhoto) {
        [buttonTapForTakingPhoto setImage:img forState:UIControlStateNormal];
        [photosTaken setObject:img forKey:[NSNumber numberWithInt:buttonTapForTakingPhoto.tag]];
    }

    //保存头像, 需要发送请求到服务器
    
    [picker dismissModalViewControllerAnimated:YES];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissModalViewControllerAnimated:YES];
}
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)context{
    /*
     if(error != nil){//出错了
     [Dialog alert:titleSomethingWrong :@"抱歉，照片存储出错，请重试":@"哦" withDelegate:self];
     return;
     }
     */
}

#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    infoArray = [[NSArray alloc] initWithObjects:@"标题",@"描述",@"价格",@"发布到",@"发布到微博", nil];
    infoFieldName = [[NSArray alloc] initWithObjects:@"title",@"desc",@"price",@"to",@"weibo", nil];
    infoFieldValue = [[NSMutableDictionary alloc] init];
    photosTaken = [[NSMutableDictionary alloc] init];
    toStreets  = [[NSMutableArray alloc] init];
    
    _customStatusBar = [[CustomStatusBar alloc] initWithFrame:CGRectZero];
    
    [((UIScrollView*)self.view) setContentSize:CGSizeMake(320, 475)];
    
    [self reset:nil];
    //[infoFieldValue setObject:[NSNumber numberWithBool:YES] forKey:[NSNumber numberWithInt:4]];
    
    [uploadScrollView loadData];//这样InfoScrollView才会渲染
    
    [infoTable reloadData];
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
    
    [lf release];
    [rf release];
    
    //显示用户当前选择发布的街道, 首次进入是没有街道的
    to.text = [self getToStreetsString:YES];
    
    
    
    //self.tabBarController.navigationItem.leftBarButtonItem = nil;
     
    [super viewWillAppear:animated];
}

@end
