//
//  UIViewController+Hamburger.m
//  doge
//
//  Created by Ben Taylor on 3/11/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "UIViewController+Hamburger.h"

@implementation UIViewController (Hamburger)

- (PPLHamburgerViewController *) hamburgerViewController {
  UIViewController *parentViewController = self.parentViewController;
  while (parentViewController) {
    if ([[parentViewController class] isSubclassOfClass:[PPLHamburgerViewController class]]) {
      return (PPLHamburgerViewController *)parentViewController;
    }
    parentViewController = parentViewController.parentViewController;
  }
  
  return nil;
}

- (void) toggleHamburger {
  [self toggleHamburgerAnimated:YES];
}

- (void) toggleHamburgerAnimated:(BOOL)animated {
  [self.hamburgerViewController toggleIsOpenAnimated:animated];
}


@end
