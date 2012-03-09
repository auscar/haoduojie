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
    UIViewController *rootController;
    UITabBarController *tabBarController;
    UINavigationController *navController;
}

@property (strong, nonatomic) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UIViewController *rootController;
@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;
@property (nonatomic, retain) IBOutlet UINavigationController *navController;

@end
