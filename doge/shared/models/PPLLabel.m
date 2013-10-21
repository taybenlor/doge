//
//  PPLLabel.m
//  doge
//
//  Created by Ben Taylor on 7/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLLabel.h"

@interface PPLLabel()

@property NSInteger fontSizeIndex;

@end

@implementation PPLLabel

- (id) init {
  if (self = [super init]) {
    self.text = @"wow";
    self.color = DOGE_RED;
    self.rotation = 1.0;
    self.position = CGPointMake(0.4, 0.4);
    self.fontSizeIndex = arc4random_uniform([PPLLabel fontSizes].count);
    [self updateFontSize];
  }
  return self;
}

- (void) increaseFontSize {
  self.fontSizeIndex = MIN([PPLLabel fontSizes].count - 1, self.fontSizeIndex + 1);
  [self updateFontSize];
}

- (void) decreaseFontSize {
  self.fontSizeIndex = MAX(0, self.fontSizeIndex - 1);
  [self updateFontSize];
}

- (void) updateFontSize {
  self.fontSize = [[PPLLabel fontSizes][self.fontSizeIndex] doubleValue];
}

+ (NSArray *) fontSizes {
  static NSArray *fontSizes;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    NSMutableArray *mutableFontSizes = [NSMutableArray array];
    double fontSize = 12;
    for (int i = 0; i < 8; i++) {
      [mutableFontSizes addObject:@(fontSize)];
      fontSize *= 1.2;
    }
    fontSizes = mutableFontSizes;
  });
  return fontSizes;
}

@end
