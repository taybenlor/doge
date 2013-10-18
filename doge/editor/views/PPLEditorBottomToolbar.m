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
    self.editButton = [[UIBarButtonItem alloc] initWithTitle:@"edit" style:UIBarButtonItemStylePlain target:self action:@selector(editButtonTapped:)];
    self.increaseSizeButton = [[UIBarButtonItem alloc] initWithTitle:@"-" style:UIBarButtonItemStylePlain target:self action:@selector(decreaseSizeButtonTapped:)];
    self.decreaseSizeButton = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(increaseSizeButtonTapped:)];
    self.deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"delete" style:UIBarButtonItemStylePlain target:self action:@selector(deleteButtonTapped:)];
    
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
