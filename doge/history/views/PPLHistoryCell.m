//
//  PPLHistoryCell.m
//  doge
//
//  Created by Ben Taylor on 3/11/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLHistoryCell.h"

@interface PPLHistoryCell()

@property UIImageView *fullImageView;

@end

@implementation PPLHistoryCell

- (instancetype) init {
  if (self = [super init]) {
    self.fullImageView = [[UIImageView alloc] init];
    self.fullImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.imageView];
    self.imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.imageView.frame = CGRectMake(0,0,200,200);
  }
  return self;
}

- (instancetype) initWithImage:(PPLImage *)image {
  if (self = [self init]) {
    self.image = image;
  }
  return self;
}


#pragma mark - Class Methods

+ (CGFloat) cellHeight {
  return 200;
}


#pragma mark - UITableViewCell Overrides

- (void) prepareForReuse {
  [super prepareForReuse];
}


#pragma mark - Properties

- (void) setDogeImage:(PPLImage *)dogeImage {
  _dogeImage = dogeImage;
  self.fullImageView.image = dogeImage.renderedImage;
}

@end
