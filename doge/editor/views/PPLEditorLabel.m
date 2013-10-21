//
//  PPLLabelView.m
//  doge
//
//  Created by Ben Taylor on 12/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLEditorLabel.h"
#import "PPLDashedRoundedRectView.h"

#define BORDER_PAD 6.0
#define BORDER_WIDTH 2.0
#define CORNER_RADIUS 3.0

@interface PPLEditorLabel()

@property id<MASConstraint> leftConstraint;
@property id<MASConstraint> topConstraint;

@property PPLDashedRoundedRectView *borderView;
@property UITapGestureRecognizer *doubleTapRecognizer;

@end

@implementation PPLEditorLabel

- (id) init {
  if (self = [super init]) {
    self.clipsToBounds = NO;
    self.doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped)];
    self.doubleTapRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:self.doubleTapRecognizer];
  }
  return self;
}

- (id) initWithLabel:(PPLLabel *)label {
  if (self = [self init]) {
    self.label = label;
  }
  return self;
}

- (void) dealloc {
  [self unobserveLabel];
  [self removeGestureRecognizer:self.doubleTapRecognizer];
}


#pragma mark - Public Methods

- (void) updateAttributes {
  self.text = self.label.text;
  self.textColor = self.label.color;
  self.font = [UIFont fontWithName:DOGE_FONT_NAME size:self.label.fontSize];
  
  [self sizeToFit];
  if (self.superview) {
    CGSize superviewSize = self.superview.frame.size;
    CGFloat leftOffset = self.label.position.x * superviewSize.width;
    CGFloat topOffset = self.label.position.y * superviewSize.height;
    
    if (self.leftConstraint) {
      self.leftConstraint.offset(leftOffset);
      self.topConstraint.offset(topOffset);
    } else {
      [self makeConstraints:^(MASConstraintMaker *make) {
        self.leftConstraint = make.left.equalTo(self.superview).with.offset(leftOffset);
        self.topConstraint = make.top.equalTo(self.superview).with.offset(topOffset);
      }];
    }
  }
  [self.borderView setNeedsDisplay];
}


#pragma mark - Private Methods

- (void) doubleTapped {
  if ([self.delegate respondsToSelector:@selector(editorLabelDidTriggerEdit:)]) {
    [self.delegate editorLabelDidTriggerEdit:self];
  }
}

- (void) observeLabel {
  [self.label addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
  [self.label addObserver:self forKeyPath:@"color" options:NSKeyValueObservingOptionNew context:nil];
  [self.label addObserver:self forKeyPath:@"rotation" options:NSKeyValueObservingOptionNew context:nil];
  [self.label addObserver:self forKeyPath:@"fontSize" options:NSKeyValueObservingOptionNew context:nil];
  [self.label addObserver:self forKeyPath:@"position" options:NSKeyValueObservingOptionNew context:nil];
}

- (void) unobserveLabel {
  [self.label removeObserver:self forKeyPath:@"text"];
  [self.label removeObserver:self forKeyPath:@"color"];
  [self.label removeObserver:self forKeyPath:@"rotation"];
  [self.label removeObserver:self forKeyPath:@"fontSize"];
  [self.label removeObserver:self forKeyPath:@"position"];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if (object == self.label) {
    [self updateAttributes];
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}


#pragma mark - Properties

- (void) setLabel:(PPLLabel *)label {
  [self unobserveLabel];
  _label = label;
  [self updateAttributes];
  [self observeLabel];
}

- (void) setEditing:(BOOL)editing {
  _editing = editing;
  
  if (editing) {
    self.borderView = [[PPLDashedRoundedRectView alloc] init];
    [self addSubview:self.borderView];
    [self.borderView makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(-BORDER_PAD/6, -BORDER_PAD, -BORDER_PAD, -BORDER_PAD));
    }];
  } else {
    [self.borderView removeFromSuperview];
    self.borderView = nil;
  }
}

@end
