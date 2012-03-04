//
//  haoduojieAppDelegate.h
//  haoduojie
//
//  Created by  on 12-2-28.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface haoduojieAppDelegate : UIResponder <UIApplicationDelegate>{
    UIWindow *window;
    UITabBarController *rootController;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UITabBarController *rootController;

@end
