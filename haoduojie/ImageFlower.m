//
//  ImageFlower.m
//  demo
//
//  Created by  on 12-3-14.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//



#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"
#import "ASICacheDelegate.h"
#import "SBJson.h"

#import "ImageFlower.h"
#import "ImageFlow.h"
#import "ImageLoader.h"
#import "ImageFlowerButton.h"
#import "Good.h"
#import "GoodDetailController.h"

@implementation ImageFlower
@synthesize delegate;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

-(CGFloat) getHeight:(UIImage *)image withWidth:(CGFloat)width{
    if(!image)return 0.0f;
    
    CGFloat rate = image.size.height/image.size.width;
    
    return floor(width*rate);
    
}
-(void) didFinishRequest:(ASIHTTPRequest *)req{
    NSLog(@"图片%@ 有返回",[req.url absoluteString]);
    NSLog(@"请求的状态码是%d", [req responseStatusCode] );
    NSLog(@"%@", [req responseString]);
    NSDictionary* obj = [[req responseString] JSONValue];
    
    NSArray* flow =  (NSArray*)[obj objectForKey:@"flow"];
    //获取服务器返回的数据, 此时这些图片都还是只是一个url
    //imgf.images = [[NSMutableArray alloc] initWithArray:flow];
    
    NSLog(@"服务器返回的数组的长度是: %d",[flow count]);
    
    items = [[NSMutableArray alloc] initWithArray:flow];
    images = [[NSMutableArray alloc] init];
    
    for (int i = 0; i<[items count]; i++) {
        [images addObject:[NSNumber numberWithInt:0]];
    }
    
    //取得了所需要的数据之后, init ImageFlow, 这样相关的ImageFlowDataSource代理方法将会被执行 
    
    [imgf loadData];//计算位置, 然后显示flow内的view
    
    
    //NSLog(@"flow 的长度是%d", [imgf.images count]);
    
}

-(void)loadFromURL:(NSString *)url{
    NSLog(@"异步获街道的flow数据 %@", url);
    NSURL *uri = [[NSURL alloc] initWithString:url];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:uri];
    req.delegate = self;
    req.didFinishSelector = @selector(didFinishRequest:);
    req.didFailSelector = @selector(didFailRequest:);
    //[req startSynchronous];
    [req startAsynchronous];
}
-(void)flowCellTapped:(id)sender{
    ImageFlowerButton* btn = (ImageFlowerButton*)sender;
    NSLog(@"传给delegate的goodId:%d",btn.good.goodId);
    [delegate imageFlower:self flowerCellDidTappedWithTarget:btn.good];
    
}

#pragma mark - ImageFlowDelegate, ImageFlowDataSource
-(int)imageFlow:(ImageFlow *)flow heightForIndex:(int)index{
    if ([[images objectAtIndex:index] isKindOfClass:[NSNumber class]]) {
        return 180;
    }else{
        return [self getHeight:(UIImage*)[images objectAtIndex:index] withWidth:151];
    }
}

-(UIView*)imageFlow:(ImageFlow *)flow viewForIndex:(int)index{
    ImageFlowerButton* btn = (ImageFlowerButton*)[flow getCacheViewForIndex:index];
    
    NSDictionary* obj = [items objectAtIndex:index];
    if (btn == nil) {
        btn = [[ImageFlowerButton alloc] init];
        Good* good = [[Good alloc] init];
        [good setGoodId:[[obj objectForKey:@"goodId"] intValue]];
        [good setOwnerId:[[obj objectForKey:@"ownerId"] intValue]];
        [good setStreetId:[[obj objectForKey:@"streetId"] intValue]];
        [good setPrice:[[obj objectForKey:@"price"] floatValue]];
        [good setLikeNum:[[obj objectForKey:@"likeNum"] intValue]];
        
        [good setIsUserLike:[[obj objectForKey:@"isUserLike"] boolValue]];
        
        [good setGoodImageLarge:[obj objectForKey:@"goodImgLarge"]];
        [good setPriceType:[obj objectForKey:@"priceType"]];
        [good setStreetName:[obj objectForKey:@"streetName"]];
        [good setOwnerName:[obj objectForKey:@"ownerName"]];
        [good setGoodName:[obj objectForKey:@"goodName"]];
        [good setGoodImage:[obj objectForKey:@"goodImg"]];
        [good setOwnerHead:[obj objectForKey:@"ownerHead"]];
        [btn setGood:good];
        [btn addTarget:self action:@selector(flowCellTapped:) forControlEvents:UIControlEventTouchUpInside];
        
        [good release];
    }
    
    if ([[images objectAtIndex:index] isKindOfClass:[NSNumber class]]) {
        [ImageLoader loadImageUsingSrc:[obj objectForKey:@"goodImg"] usingBlock:^(UIImage* image){
            [btn setImage:image forState:UIControlStateNormal];
            [images replaceObjectAtIndex:index withObject:image];//记录下来说这个图片已经加载了
            //再重新显示一下
            [imgf loadData];
        }];
    }else{
        [btn setImage:[images objectAtIndex:index] forState:UIControlStateNormal];
    }
    
    return btn;
}
-(int)countOfItems{
    return [items count];
}




#pragma mark - View lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    imgf = [[ImageFlow alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    //imgf = [[ImageFlow alloc] initWithFrame:self.view.frame];
    imgf.delegate = self;
    [self.view addSubview:imgf.view];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
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
-(void) dealloc{
    [imgf release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
