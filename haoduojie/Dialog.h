//
//  Dialog.h
//  zhamr
//
//  Created by  on 11-9-6.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dialog : NSObject

+(UIAlertView*) alertWithTitle:(NSString *)title withMessage:(NSString *)message withConfirmText:(NSString *)confirmText withDelegate:delegate;
+(void) yesOrNoConfirm:(NSString *)title:(NSString *)message:(NSString *)yesText:noText withDelegate:(id)delegate;
@end
