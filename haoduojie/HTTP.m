//
//  HTTP.m
//  haoduojie
//
//  Created by  on 12-3-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import "HTTP.h"
#import "ASIHTTPRequest.h"
#import "ASIDownloadCache.h"

@implementation HTTP

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

+(void)didFinishRequest:(ASIHTTPRequest*)req{
    NSLog(@"%@ 数据有返回",[req.url absoluteString]);
    LoadedBlock callback = [req.userInfo objectForKey:@"block"];
    
    callback(req);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


+(void) loadUsingSrc:(NSString*)src usingBlock:(LoadedBlock)block{
    NSLog(@"异步请求:%@",src);
    NSURL *uri = [[NSURL alloc] initWithString:src];
    __block ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:uri];
    [req setCompletionBlock:^{
        block(req);
        [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    }];
    /*
    req.delegate = [HTTP class];
    req.didFinishSelector = @selector(didFinishRequest:);
    //这个userInfo是不是该realease呀？
    req.userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:block,@"block", nil];
    //req.didFailSelector = @selector(didFinishRequest:);
     */
    [req setDownloadCache:[ASIDownloadCache sharedCache]];
    //[req setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];//缓存策略是仅使用缓存的数据, 不再向服务器发请求
    [req startAsynchronous];
    
    //[uri release];
    //[req release];
}
@end
