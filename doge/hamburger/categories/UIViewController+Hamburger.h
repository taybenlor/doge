//
//  UIViewController+Hamburger.h
//  doge
//
//  Created by Ben Taylor on 3/11/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLHamburgerViewController.h"

@interface UIViewController (Hamburger)

@property (readonly) PPLHamburgerViewController *hamburgerViewController;

- (void) toggleHamburger;
- (void) toggleHamburgerAnimated:(BOOL)animated;
@end
