//
//  KIFTestActor+PickPhoto.m
//  doge
//
//  Created by Ben Taylor on 22/11/2013.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "KIFUITestActor+NavigationHelpers.h"

@implementation KIFUITestActor (NavigationHelpers)

- (void) pickPhoto {
  [self tapViewWithAccessibilityLabel:@"Choose photo"];
  [self waitForViewWithAccessibilityLabel:@"Photo editor"];
}

- (void) newPhoto {
  [self tapViewWithAccessibilityLabel:@"New doge"];
  [self waitForTappableViewWithAccessibilityLabel:@"Trash it"];
  [self tapViewWithAccessibilityLabel:@"Trash it"];
}

@end
