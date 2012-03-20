//
//  ImageLoader.m
//  haoduojie
//
//  Created by  on 12-3-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "ImageLoader.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

@implementation ImageLoader

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
+(void)didFinishDownload:(ASIHTTPRequest*)req{
    NSLog(@"图片%@ 有返回",[req.url absoluteString]);
    ImageLoadedBlock callback = [req.userInfo objectForKey:@"block"];
    
    //NSLog(@"请求的状态码是%d", [req responseStatusCode] );
    NSData *imageDate = [req responseData];
    UIImage *image = [UIImage imageWithData:imageDate];
    if(image != nil){
        callback(image);
    }else{
        NSLog(@"         没有图片数据..................");
       
    }
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


+(void) loadImageUsingSrc:(NSString*)src usingBlock:(ImageLoadedBlock)block{
    //block([UIImage imageNamed:@"h1.jpg"]);
    
    NSLog(@"异步获取图片data:%@",src);
    NSURL *uri = [[NSURL alloc] initWithString:src];
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:uri];
    req.delegate = [ImageLoader class];
    req.didFinishSelector = @selector(didFinishDownload:);
    //这个userInfo是不是该realease呀？
    req.userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:block,@"block", nil];
    //req.userInfo = [NSDictinary alloc] initwithObjectAndKeys:
    req.username = [NSString stringWithFormat:@"%d",index];
    req.didFailSelector = @selector(didFailDownload:);
    [req setDownloadCache:[ASIDownloadCache sharedCache]];
    [req setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];//缓存策略是仅使用缓存的数据, 不再向服务器发请求
    [req startSynchronous];
    
}
@end
