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

@interface PPLEditorView ()

@property UIImageView *imageView;
@property UIImageView *overlayView;
@property PPLEditorTopToolbar *topToolbar;
@property PPLEditorBottomToolbar *bottomToolbar;
@property PPLLabelContainerView *labelContainerView;

@property PPLLabelEditorView *labelEditorView;

@property (nonatomic) NSMutableSet *editorLabels;

@property id<MASConstraint> bottomToolbarBottomConstraint;

@end

@implementation PPLEditorView

- (id) init {
  if (self = [super init]) {
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
      make.top.equalTo(self);
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
  [self presentModalView:self.labelEditorView];
  [self.labelEditorView animateIn];
}

- (void) presentLabelEditorViewWithLabel:(PPLLabel *)label {
  self.labelEditorView = [[PPLLabelEditorView alloc] initWithEditorView:self configuration:PPLLabelEditorViewConfigurationEdit];
  self.labelEditorView.currentLabel = label;
  [self presentModalView:self.labelEditorView];
  [self.labelEditorView animateIn];
}

- (void) dismissLabelEditorViewConfirmed:(BOOL)confirmed {
  if (confirmed) {
    [self.controller addOrUpdateLabel:self.labelEditorView.currentLabel];
  }
  
  [self dismissModalView:self.labelEditorView];
  self.labelEditorView = nil;
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
  self.bottomToolbarBottomConstraint.offset(0);
  [self.labelContainerView layoutIfNeeded];
  [UIView animateWithDuration:0.2 animations:^{
    [self layoutIfNeeded];
  }];
  [self.controller selectLabelTriggered:label];
}

- (void) labelContainerView:(PPLLabelContainerView *)labelContainerView didDeselectLabel:(PPLLabel *)label {
  self.bottomToolbarBottomConstraint.offset(44);
  [UIView animateWithDuration:0.2 animations:^{
    [self layoutIfNeeded];
  }];
}

- (void) labelContainerView:(PPLLabelContainerView *)labelContainerView didTriggerEditOnLabel:(PPLLabel *)label {
  [self presentLabelEditorViewWithLabel:label];
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
