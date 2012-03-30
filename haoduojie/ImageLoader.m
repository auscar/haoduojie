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


+(void) loadImageUsingSrc:(NSString*)src usingBlock:(ImageLoadedBlock)block{
    //block([UIImage imageNamed:@"h1.jpg"]);
    
    NSLog(@"异步获取图片data:%@",src);
    NSURL *uri = [[NSURL alloc] initWithString:src];
    __block ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:uri];
    
    [req setCompletionBlock:^{
        NSLog(@"--------------图片%@ 有返回",[req.url absoluteString]);
        NSData *imageDate = [req responseData];
        UIImage *image = [UIImage imageWithData:imageDate];
        block(image);        
    }];
    
    [req setDownloadCache:[ASIDownloadCache sharedCache]];
    [req setCachePolicy:ASIOnlyLoadIfNotCachedCachePolicy];//缓存策略是仅使用缓存的数据, 不再向服务器发请求
    [req startAsynchronous];
    
}
@end
