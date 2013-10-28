//
//  PPLAlertView.m
//  doge
//
//  Created by Ben Taylor on 28/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLAlertView.h"

#define ANIMATION_DURATION 0.2
#define OVERLAY_COLOUR ([UIColor colorWithWhite:0.0 alpha:0.4])

@interface PPLAlertView ()
@property UIView *overlayView;
@property UIView *containerView;
@property UIWindow *window;
@property UIWindow *previousWindow;
@end

@implementation PPLAlertView

- (instancetype) init {
  if (self = [super init]) {
    self.overlayView = self;
    self.backgroundColor = OVERLAY_COLOUR;
    self.containerView = [[UIView alloc] init];
    self.containerView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.85];
    self.containerView.layer.cornerRadius = DOGE_CORNER_RADIUS;
    [self addSubview:self.containerView];
    
    /* Try this out again when you have some time
     UIToolbar *containerView = [[UIToolbar alloc] init];
     containerView.translucent = YES;
     containerView.layer.cornerRadius = DOGE_CORNER_RADIUS;
     [self addSubview:containerView];
     self.containerView = containerView;
     */
  }
  return self;
}


# pragma mark - Private Display Behaviour

- (void) preshow {
  self.previousWindow = [UIApplication sharedApplication].keyWindow;
  self.window = [[UIWindow alloc] initWithFrame:self.previousWindow.frame];
  self.window.windowLevel = UIWindowLevelAlert;
  [self.window addSubview:self];
  
  [self makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(self.superview);
  }];
  
  [self.containerView makeConstraints:^(MASConstraintMaker *make) {
    make.center.equalTo(self);
  }];
  
  [self.window makeKeyAndVisible];
}

- (void) animateIn {
  self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
  self.containerView.layer.transform = CATransform3DMakeScale(1.2, 1.2, 1.0);
  self.containerView.alpha = 0.0;
  
  [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
    self.backgroundColor = OVERLAY_COLOUR;
    self.containerView.layer.transform = CATransform3DIdentity;
    self.containerView.alpha = 1.0;
    self.previousWindow.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
  } completion:nil];
}

- (void) animateOut {
  [UIView animateWithDuration:ANIMATION_DURATION delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
    self.containerView.layer.transform = CATransform3DMakeScale(0.8, 0.8, 1.0);
    self.containerView.alpha = 0.0;
    self.previousWindow.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
  } completion:^(BOOL finished) {
    [self teardown];
  }];
}

- (void) teardown {
  self.previousWindow.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
  [self.previousWindow makeKeyAndVisible];
  [self removeFromSuperview];
  [self.window removeFromSuperview];
  self.window = nil;
}

# pragma mark - Public Display Behaviour

- (void) show {
  [self showAnimated:YES];
}

- (void) dismiss {
  [self dismissAnimated:YES];
}

- (void) showAnimated:(BOOL)animated {
  [self preshow];
  if (animated) {
    [self animateIn];
  } else {
    self.previousWindow.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
  }
}

- (void) dismissAnimated:(BOOL)animated {
  if (animated) {
    [self animateOut];
  } else {
    [self teardown];
  }
}


# pragma mark - Properties

- (void) setContainedView:(UIView *)containedView {
  [_containedView removeFromSuperview];
  _containedView = containedView;
  [self.containerView addSubview:containedView];
  
  [self.containerView makeConstraints:^(MASConstraintMaker *make) {
    make.width.equalTo(self.containedView);
    make.height.equalTo(self.containedView);
  }];
  
  [self.containedView makeConstraints:^(MASConstraintMaker *make) {
    make.left.equalTo(self.containerView);
    make.top.equalTo(self.containerView);
  }];
}



@end
