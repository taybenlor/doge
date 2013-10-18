//
//  PPLLabel.m
//  doge
//
//  Created by Ben Taylor on 7/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLLabel.h"

@implementation PPLLabel

- (id) init {
  if (self = [super init]) {
    self.text = @"wow";
    self.color = DOGE_RED;
    self.rotation = 1.0;
    self.position = CGPointMake(0.5, 0.5);
    self.fontSize = 32;
  }
  return self;
}

@end
