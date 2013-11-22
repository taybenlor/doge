//
//  UIView+ScreenPositionHelpers.m
//  doge
//
//  Created by Ben Taylor on 22/11/2013.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "UIView+ScreenPositionHelpers.h"

@implementation UIView (ScreenPositionHelpers)

- (CGPoint) originOffsetFromRootView {
  if (self.superview) {
    CGPoint superOrigin = self.superview.originOffsetFromRootView;
    CGPoint selfOrigin = self.frame.origin;
    return CGPointMake(superOrigin.x + selfOrigin.x, superOrigin.y + selfOrigin.y);
  }
  return CGPointMake(0, 0);
}

@end
