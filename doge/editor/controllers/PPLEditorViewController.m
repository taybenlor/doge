//
//  PPLEditorViewController.m
//  doge
//
//  Created by Ben Taylor on 4/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLEditorViewController.h"
#import "PPLLabel.h"
#import "PPLEditorView.h"

@interface PPLEditorViewController ()
@property (nonatomic) NSMutableSet *labels;
@property PPLEditorView *view;
@end

@implementation PPLEditorViewController

- (id) init {
  if (self = [super init]) {
    self.view = [[PPLEditorView alloc] initWithController:self];
    self.navigationItem.title = @"Doge App";
  }
  return self;
}

- (id) initWithImage:(UIImage *)image {
  if (self = [self init]) {
    NSLog(@"Yo setting the image %@", image);
    self.image = image;
  }
  return self;
}

- (void) viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view.
}


# pragma mark - Properties

- (NSMutableSet *) labels {
  if (_labels) return _labels;
  return _labels = [NSMutableSet set];
}


#pragma mark - Public Methods

- (void) addOrUpdateLabel:(PPLLabel *)label {
  [self.labels addObject:label];
  [self.view updateLabels];
}


#pragma mark - Triggerable Events

- (void) addLabelTriggered {
  [self.view presentLabelEditorView];
}

- (void) addDogeTriggered {
  NSLog(@"Do stuff to add a doge");
}

- (void) selectLabelTriggered:(PPLLabel *)label {
  NSLog(@"Select this label: %@", label);
  self.selectedLabel = label;
}

- (void) editLabelTriggered {
  NSLog(@"Do stuff to edit the current label");
}

- (void) increaseLabelSizeTriggered {
  NSLog(@"Increase label size");
}

- (void) decreaseLabelSizeTriggered {
  NSLog(@"Decrease label size");
}

- (void) deleteLabelTriggered {
  NSLog(@"Delete label");
}

@end
