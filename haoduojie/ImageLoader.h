//
//  ImageLoader.h
//  haoduojie
//
//  Created by  on 12-3-20.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^ImageLoadedBlock)(UIImage* image);

@interface ImageLoader : NSObject{

}
+(void) loadImageUsingSrc:(NSString*)src usingBlock:(ImageLoadedBlock)block;
@end
