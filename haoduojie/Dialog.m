//
//  Dialog.m
//  zhamr
//
//  Created by  on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "Dialog.h"

@implementation Dialog

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}
//+(void)alert:(NSString *)title :(NSString *)message :(NSString *)confirmText withDelegate:(id)delegate{
+(UIAlertView*) alertWithTitle:(NSString *)title withMessage:(NSString *)message withConfirmText:(NSString *)confirmText withDelegate:delegate{
    UIAlertView *alert = [[UIAlertView alloc] init];
    [alert setTitle:title];
    [alert setMessage:message];
    [alert setDelegate:delegate];
    [alert addButtonWithTitle:confirmText];
    [alert show]; 
    return alert;
}
+(void)yesOrNoConfirm:(NSString *)title :(NSString *)message :(NSString *)yesText :(id)noText withDelegate:(id)delegate{
    
}
@end
