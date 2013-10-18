//
//  PPLEditorTopToolbar.m
//  doge
//
//  Created by Ben Taylor on 8/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLEditorTopToolbar.h"

@interface PPLEditorTopToolbar ()

@property UIBarButtonItem *addLabelButton;
@property UIBarButtonItem *addDogeButton;

@end

@implementation PPLEditorTopToolbar

- (id) init {
  if (self = [super init]) {
    self.addLabelButton = [[UIBarButtonItem alloc] initWithTitle:@"+Label" style:UIBarButtonItemStylePlain target:self action:@selector(addLabelButtonTapped:)];
    self.addDogeButton = [[UIBarButtonItem alloc] initWithTitle:@"+Doge" style:UIBarButtonItemStylePlain target:self action:@selector(addDogeButtonTapped:)];
    self.items = @[self.addLabelButton, self.addDogeButton];
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

- (void) addLabelButtonTapped:(id)sender {
  [self.editorView.controller addLabelTriggered];
}

- (void) addDogeButtonTapped:(id)sender {
  [self.editorView.controller addDogeTriggered];
}

@end
