//
//  PPLLabelEditorView.m
//  doge
//
//  Created by Ben Taylor on 10/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLLabelEditorView.h"
#import "PPLColourPickerView.h"
#import "PPLInsetTextField.h"

#define EDGE_PADDING 6
#define TEXT_FIELD_HEIGHT 32
#define BUTTON_HEIGHT 44
#define MODAL_HEIGHT 254
#define MODAL_WIDTH 294
#define PADDING 16

@interface PPLLabelEditorView ()

@property UIView *modalView;

@property PPLInsetTextField *textField;

@property UIControl *rotationControl;
@property PPLColourPickerView *colourPickerView;

@property UIButton *cancelButton;
@property UIButton *confirmButton;

@end

@implementation PPLLabelEditorView

- (id) init {
  if (self = [super init]) {
    self.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.5];
    self.modalView = [[UIView alloc] init];
    self.modalView.backgroundColor = [UIColor colorWithWhite:1.0 alpha:0.85];
    self.modalView.layer.cornerRadius = DOGE_CORNER_RADIUS;
    [self addSubview:self.modalView];
    [self.modalView makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self);
      make.width.equalTo(@MODAL_WIDTH);
      make.height.equalTo(@MODAL_HEIGHT);
    }];
    
    self.textField = [[PPLInsetTextField alloc] init];
    self.textField.font = [UIFont fontWithName:DOGE_FONT_NAME size:18.0];
    self.textField.textColor = DOGE_STEEL;
    self.textField.text = @"wow";
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.layer.cornerRadius = DOGE_CORNER_RADIUS;
    self.textField.edgeInsets = UIEdgeInsetsMake(0, EDGE_PADDING, 0, EDGE_PADDING);
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.delegate = self;
    [self.modalView addSubview:self.textField];
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.modalView).with.offset(EDGE_PADDING);
      make.left.equalTo(self.modalView).with.offset(EDGE_PADDING);
      make.right.equalTo(self.modalView).with.offset(-EDGE_PADDING);
      make.height.equalTo(@TEXT_FIELD_HEIGHT);
    }];
    
    self.colourPickerView = [[PPLColourPickerView alloc] init];
    [self.modalView addSubview:self.colourPickerView];
    [self.colourPickerView makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.textField.bottom).with.offset(PADDING);
      make.left.equalTo(self.modalView).with.offset(PADDING);
      make.right.equalTo(self.modalView).with.offset(PADDING);
      make.height.equalTo(@150);
    }];
    
    NSString *cancelButtonText = NSLocalizedString(@"cancel", @"cancel button text");
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:cancelButtonText forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:DOGE_RED forState:UIControlStateNormal];
    [self.modalView addSubview:self.cancelButton];
    [self.cancelButton makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self.modalView);
      make.left.equalTo(self.modalView);
      make.width.equalTo(self.modalView).dividedBy(2.0);
      make.height.equalTo(@BUTTON_HEIGHT);
    }];
    [self.cancelButton addTarget:self
                          action:@selector(cancelButtonTapped:)
                forControlEvents:UIControlEventTouchUpInside];
    
    NSString *confirmButtonText = NSLocalizedString(@"add", @"confirm button text");
    self.confirmButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.confirmButton setTitle:confirmButtonText forState:UIControlStateNormal];
    [self.confirmButton setTitleColor:DOGE_RED forState:UIControlStateNormal];
    self.confirmButton.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    [self.modalView addSubview:self.confirmButton];
    [self.confirmButton makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self.modalView);
      make.right.equalTo(self.modalView);
      make.width.equalTo(self.modalView).dividedBy(2.0);
      make.height.equalTo(@BUTTON_HEIGHT);
    }];
    [self.confirmButton addTarget:self
                           action:@selector(confirmButtonTapped:)
                 forControlEvents:UIControlEventTouchUpInside];
    
  }
  return self;
}

- (id) initWithEditorView:(PPLEditorView *)editorView {
  if (self = [self init]) {
    self.editorView = editorView;
  }
  return self;
}

- (id) initWithEditorView:(PPLEditorView *)editorView configuration:(PPLLabelEditorViewConfiguration)configuration {
  if (self = [self initWithEditorView:editorView]) {
    self.configuration = configuration;
  }
  return self;
}


#pragma mark - Properties

- (PPLLabel *) currentLabel {
  if (_currentLabel) return _currentLabel;
  return _currentLabel = [[PPLLabel alloc] init];
}

- (void) setLabel:(PPLLabel *)currentLabel {
  _currentLabel = currentLabel;
  self.textField.text = currentLabel.text;
}

- (void) setConfiguration:(PPLLabelEditorViewConfiguration)configuration {
  _configuration = configuration;
  NSString *confirmButtonText;
  
  if (self.configuration == PPLLabelEditorViewConfigurationCreate) {
    confirmButtonText = NSLocalizedString(@"add", @"confirm button text");
  } else {
    confirmButtonText = NSLocalizedString(@"update", @"confirm button text");
  }
  
  [self.confirmButton setTitle:confirmButtonText forState:UIControlStateNormal];
}


# pragma mark - UITextFieldDelegate

- (BOOL) textFieldShouldReturn:(UITextField *)textField {
  [textField resignFirstResponder];
  return NO;
}


# pragma mark - Triggers

- (void) cancelButtonTapped:(id)sender {
  [self.editorView dismissLabelEditorViewConfirmed:NO];
}

- (void) confirmButtonTapped:(id)sender {
  self.currentLabel.text = self.textField.text;
  self.currentLabel.rotation = 0.0;
  self.currentLabel.color = self.colourPickerView.pickedColour;
  [self.editorView dismissLabelEditorViewConfirmed:YES];
}


@end
