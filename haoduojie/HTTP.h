//
//  HTTP.h
//  haoduojie
//
//  Created by  on 12-3-24.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

typedef void(^LoadedBlock)(ASIHTTPRequest* req);
@interface HTTP : NSObject
+(void) loadUsingSrc:(NSString*)src usingBlock:(LoadedBlock)block;

@end
