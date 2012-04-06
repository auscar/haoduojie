//
//  PhotoHelper.m
//  zhamr
//
//  Created by  on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "PhotoHelper.h"

@implementation PhotoHelper

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}


+(void) getMediaFromSource:(UIImagePickerControllerSourceType)sourceType withDelegate:delegate{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0){
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = delegate;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [delegate presentModalViewController:picker animated:YES];
    }else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"error accesing media" message:@"device doesn't support that media source" delegate:nil cancelButtonTitle:@"Drat!" otherButtonTitles:nil];
        [alert show];
    }
}

@end
