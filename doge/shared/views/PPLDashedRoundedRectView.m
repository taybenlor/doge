//
//  PPLDashedRoundedRectView.m
//  doge
//
//  Created by Ben Taylor on 20/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLDashedRoundedRectView.h"

#define CORNER_RADIUS

@implementation PPLDashedRoundedRectView

- (instancetype) init {
  if (self = [super init]) {
    self.colour = [UIColor whiteColor];
    self.cornerRadius = 3;
    [self setOpaque:NO];
  }
  return self;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();

  CGContextSetStrokeColorWithColor(context, self.colour.CGColor);
  CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);

  CGFloat dashes[] = {6,6};

  UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:self.cornerRadius];
  
  CGContextSetLineDash(context, 0.0, dashes, 2);
  
  CGContextSetLineWidth(context, 4.0);

  CGContextAddPath(context, roundedRect.CGPath);
  CGContextSetShouldAntialias(context, NO);
  CGContextStrokePath(context);
}

@end
