//
//  PPLEditorBottomToolbar.m
//  doge
//
//  Created by Ben Taylor on 8/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLEditorBottomToolbar.h"

@interface PPLEditorBottomToolbar ()

@property UIBarButtonItem *editButton;
@property UIBarButtonItem *decreaseSizeButton;
@property UIBarButtonItem *increaseSizeButton;
@property UIBarButtonItem *deleteButton;

@end

@implementation PPLEditorBottomToolbar

- (id) init {
  if (self = [super init]) {
    self.accessibilityLabel = @"Bottom toolbar";
    
    self.editButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"edit-button.png"]
                                                       style:UIBarButtonItemStylePlain
                                                      target:self
                                                      action:@selector(editButtonTapped:)];
    self.increaseSizeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bigger-button.png"]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(increaseSizeButtonTapped:)];
    self.decreaseSizeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"smaller-button.png"]
                                                               style:UIBarButtonItemStylePlain
                                                              target:self
                                                              action:@selector(decreaseSizeButtonTapped:)];
    self.deleteButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"delete-button.png"]
                                                         style:UIBarButtonItemStylePlain
                                                        target:self
                                                        action:@selector(deleteButtonTapped:)];
    
    self.editButton.width = 65;
    self.increaseSizeButton.width = 65;
    self.decreaseSizeButton.width = 65;
    self.deleteButton.width = 65;
    
    self.editButton.accessibilityLabel = @"Edit selected doge text";
    self.increaseSizeButton.accessibilityLabel = @"Increase selected doge text size";
    self.decreaseSizeButton.accessibilityLabel = @"Decrease selected doge text size";
    self.deleteButton.accessibilityLabel = @"Delete selected doge text";
    
    self.barStyle = UIBarStyleDefault;
    self.translucent = NO;
    
    self.items = @[self.editButton, self.decreaseSizeButton, self.increaseSizeButton, self.deleteButton];
  }
  return self;
}

- (id) initWithEditorView:(PPLEditorView *)editorView {
  if (self = [self init]) {
    self.editorView = editorView;
  }
  return self;
}


# pragma mark - Events

- (void) editButtonTapped:(id)sender {
  [self.editorView.controller editLabelTriggered];
}

- (void) increaseSizeButtonTapped:(id)sender {
  [self.editorView.controller increaseLabelSizeTriggered];
}

- (void) decreaseSizeButtonTapped:(id)sender {
  [self.editorView.controller decreaseLabelSizeTriggered];
}

- (void) deleteButtonTapped:(id)sender {
  [self.editorView.controller deleteLabelTriggered];
}

@end
