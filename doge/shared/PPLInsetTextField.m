//
//  PPLInsetTextField.m
//  doge
//
//  Created by Ben Taylor on 18/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLInsetTextField.h"

@implementation PPLInsetTextField

- (instancetype) init {
  if (self = [super init]) {
    self.edgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
  }
  return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
  return [super textRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
  return [super editingRectForBounds:UIEdgeInsetsInsetRect(bounds, self.edgeInsets)];
}

@end
