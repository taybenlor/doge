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
@property UIBarButtonItem *shareDogeButton;

@end

@implementation PPLEditorTopToolbar

- (id) init {
  if (self = [super init]) {
    self.accessibilityLabel = @"Top toolbar";
    
    NSString *addLabelText = NSLocalizedString(@"Add doge text", @"add label button text");
    NSString *shareDogeText = NSLocalizedString(@"Share doge", @"add doge button text");
    self.addLabelButton = [[UIBarButtonItem alloc] initWithTitle:addLabelText style:UIBarButtonItemStylePlain target:self action:@selector(addLabelButtonTapped:)];
    self.shareDogeButton = [[UIBarButtonItem alloc] initWithTitle:shareDogeText style:UIBarButtonItemStylePlain target:self action:@selector(shareDogeButtonTapped:)];
    
    self.addLabelButton.width = 290;
    self.addLabelButton.accessibilityLabel = @"Add doge text";
    
    self.barStyle = UIBarStyleDefault;
    self.translucent = NO;
    
    self.items = @[self.addLabelButton];
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

- (void) shareDogeButtonTapped:(id)sender {
  [self.editorView.controller shareDogeTriggered];
}

@end
