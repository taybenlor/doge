//
//  PPLEditorView.m
//  doge
//
//  Created by Ben Taylor on 4/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLEditorView.h"
#import "PPLEditorTopToolbar.h"
#import "PPLEditorBottomToolbar.h"
#import "PPLLabelEditorView.h"
#import "PPLLabelContainerView.h"
#import "PPLCustomAlertView.h"

#define ANIMATION_DURATION 0.2

@interface PPLEditorView ()

@property UIImageView *imageView;
@property UIImageView *overlayView;
@property PPLEditorTopToolbar *topToolbar;
@property PPLEditorBottomToolbar *bottomToolbar;
@property PPLLabelContainerView *labelContainerView;

@property PPLLabelEditorView *labelEditorView;

@property (nonatomic) NSMutableSet *editorLabels;

@property id<MASConstraint> bottomToolbarBottomConstraint;
@property id<MASConstraint> topToolbarTopConstraint;

@property PPLCustomAlertView *alertView;

@end

@implementation PPLEditorView

- (id) init {
  if (self = [super init]) {
    self.accessibilityLabel = @"Photo editor";
    
    self.imageView = [[UIImageView alloc] init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    [self addSubview:self.imageView];
    [self.imageView makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self);
      make.width.equalTo(@DISPLAY_IMAGE_WIDTH);
      make.height.equalTo(@DISPLAY_IMAGE_HEIGHT);
    }];
    
    self.labelContainerView = [[PPLLabelContainerView alloc] init];
    self.labelContainerView.dataSource = self;
    self.labelContainerView.delegate = self;
    [self addSubview:self.labelContainerView];
    [self.labelContainerView makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self);
      make.width.equalTo(@DISPLAY_IMAGE_WIDTH);
      make.height.equalTo(@DISPLAY_IMAGE_HEIGHT);
    }];
    
    UIImage *overlayImage = [UIImage imageNamed:@"editor-overlay.png"];
    self.overlayView = [[UIImageView alloc] initWithImage:overlayImage];
    [self addSubview:self.overlayView];
    [self.overlayView makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self);
    }];
    
    self.topToolbar = [[PPLEditorTopToolbar alloc] initWithEditorView:self];
    [self addSubview:self.topToolbar];
    [self.topToolbar makeConstraints:^(MASConstraintMaker *make) {
      self.topToolbarTopConstraint = make.top.equalTo(self);
      make.left.equalTo(self);
      make.width.equalTo(self);
      make.height.equalTo(@44);
    }];
    
    self.bottomToolbar = [[PPLEditorBottomToolbar alloc] initWithEditorView:self];
    [self addSubview:self.bottomToolbar];
    [self.bottomToolbar makeConstraints:^(MASConstraintMaker *make) {
      self.bottomToolbarBottomConstraint = make.bottom.equalTo(self).with.offset(44);
      make.left.equalTo(self);
      make.width.equalTo(self);
      make.height.equalTo(@44);
    }];
    
    self.backgroundColor = DOGE_STEEL;
  }
  return self;
}

- (id) initWithController:(PPLEditorViewController *)controller {
  if (self = [self init]) {
    self.controller = controller;
  }
  return self;
}


# pragma mark - Transitions

- (void) animateOut {
  [self hideToolbarsAnimated:YES];
  
  double delayInSeconds = ANIMATION_DURATION;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self.bottomToolbar removeFromSuperview];
    [self.topToolbar removeFromSuperview];
  });
  
  [UIView animateWithDuration:ANIMATION_DURATION delay:ANIMATION_DURATION*1.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
    CGRect blah = self.bounds;
    blah.origin.y = -blah.size.height;
    self.bounds = blah;
  } completion:^(BOOL finished) {
    
  }];
  
}

# pragma mark - Toolbars

- (void) hideToolbarsAnimated:(BOOL)animated {
  self.bottomToolbarBottomConstraint.offset(44);
  self.topToolbarTopConstraint.offset(-44);
  [self.labelContainerView layoutIfNeeded];
  
  if (animated) {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      [self layoutIfNeeded];
    }];
  } else {
    [self layoutIfNeeded];
  }
}

- (void) showEditToolbarAnimated:(BOOL)animated {
  self.bottomToolbarBottomConstraint.offset(0);
  [self.labelContainerView layoutIfNeeded];
  
  if (animated) {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      [self layoutIfNeeded];
    }];
  } else {
    [self layoutIfNeeded];
  }
}

- (void) hideEditToolbarAnimated:(BOOL)animated {
  self.bottomToolbarBottomConstraint.offset(44);
  if (animated) {
    [UIView animateWithDuration:ANIMATION_DURATION animations:^{
      [self layoutIfNeeded];
    }];
  } else {
    [self layoutIfNeeded];
  }
}


# pragma mark - Modal Views

- (void) presentModalView:(UIView *)view {
  UIView *superview = self.superview;
  while (superview.superview) {
    superview = superview.superview;
  }
  [superview addSubview:self.labelEditorView];
  [view makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview);
  }];
  superview.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
}

- (void) dismissModalView:(UIView *)view {
  UIView *superview = view.superview;
  [view removeFromSuperview];
  superview.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
}


#pragma mark - Label Editor View

- (void) presentLabelEditorView {
  self.labelEditorView = [[PPLLabelEditorView alloc] initWithEditorView:self configuration:PPLLabelEditorViewConfigurationCreate];
  [self displayLabelEditorView];
}

- (void) presentLabelEditorViewWithLabel:(PPLLabel *)label {
  self.labelEditorView = [[PPLLabelEditorView alloc] initWithEditorView:self configuration:PPLLabelEditorViewConfigurationEdit];
  self.labelEditorView.currentLabel = label;
  [self displayLabelEditorView];
}

- (void) displayLabelEditorView {
  self.alertView = [[PPLCustomAlertView alloc] init];
  self.alertView.containedView = self.labelEditorView;
  [self.alertView show];
}

- (void) dismissLabelEditorViewConfirmed:(BOOL)confirmed {
  if (confirmed) {
    [self.controller addOrUpdateLabel:self.labelEditorView.currentLabel];
  }
  
  self.labelEditorView = nil;
  [self.alertView dismiss];
}

- (void) updateLabels {
  [self.labelContainerView reloadData];
}


# pragma mark - LabelContainerViewDataSource

- (NSSet *)labelsForLabelContainerView:(PPLLabelContainerView *)labelContainerView {
  return self.controller.labels;
}


# pragma mark - LabelContainerViewDelegate

- (void) labelContainerView:(PPLLabelContainerView *)labelContainerView didSelectLabel:(PPLLabel *)label {
  [self showEditToolbarAnimated:YES];
  [self.controller selectLabelTriggered:label];
}

- (void) labelContainerView:(PPLLabelContainerView *)labelContainerView didDeselectLabel:(PPLLabel *)label {
  [self hideEditToolbarAnimated:YES];
}

- (void) labelContainerView:(PPLLabelContainerView *)labelContainerView didTriggerEditOnLabel:(PPLLabel *)label {
  [self presentLabelEditorViewWithLabel:label];
}

- (void) labelContainerViewDidTriggerNewLabel:(PPLLabelContainerView *)labelContainerView {
  [self presentLabelEditorView];
}


# pragma mark - Properties

- (void) setController:(PPLEditorViewController *)controller {
  _controller = controller;
  [controller addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
}

- (NSMutableSet *) editorLabels {
  if (_editorLabels) return _editorLabels;
  return _editorLabels = [NSMutableSet set];
}


#pragma mark - KVO

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
  if ([keyPath isEqualToString:@"image"]) {
    self.imageView.image = change[NSKeyValueChangeNewKey];
  } else {
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
  }
}

@end
