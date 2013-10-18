//
//  UINavigationController+DogeStyling.m
//  doge
//
//  Created by Ben Taylor on 5/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "UINavigationController+DogeStyling.h"

@implementation UINavigationController (DogeStyling)

- (void) styleForDoge {
  self.navigationBar.barTintColor = DOGE_RED;
  self.navigationBar.translucent = NO;
  self.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName:[UIColor whiteColor]};
}

@end
