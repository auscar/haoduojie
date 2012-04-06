//
//  PhotoHelper.h
//  zhamr
//
//  Created by  on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PhotoHelper : NSObject

+(void) getMediaFromSource:(UIImagePickerControllerSourceType)sourceType withDelegate:(NSObject*)delegate;

@end
