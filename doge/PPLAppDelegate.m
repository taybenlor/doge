//
//  PPLAppDelegate.m
//  doge
//
//  Created by Ben Taylor on 3/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLAppDelegate.h"
#import "PPLHamburgerViewController.h"
#import "PPLBlankEditorViewController.h"
#import "UINavigationController+DogeStyling.h"

@interface PPLAppDelegate ()

@property UINavigationController *navigationController;
@property PPLHamburgerViewController *hamburgerController;

@end

@implementation PPLAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  [TestFlight takeOff:@"86ed787e-5f62-49a0-a6c9-2fc05c76a695"];
  
  srand48(time(0));
  PPLBlankEditorViewController *mainViewController = [[PPLBlankEditorViewController alloc] init];
  UIViewController *menuViewController = [[UIViewController alloc] init];
  self.navigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
  self.hamburgerController = [[PPLHamburgerViewController alloc] initWithMain:self.navigationController
                                                                         menu:menuViewController];
  
  [self.navigationController styleForDoge];
  [self styleApplication];
  
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  self.window.rootViewController = self.hamburgerController;
  self.window.backgroundColor = [UIColor blackColor];
  [self.window makeKeyAndVisible];
  
  return YES;
}

- (void) styleApplication {
  [UIBarButtonItem appearance].tintColor = DOGE_RED;
  [UIButton appearance].tintColor = DOGE_RED;
  [UINavigationBar appearance].tintColor = [UIColor whiteColor];
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
