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

#define EDGE_PADDING 10
#define TEXT_FIELD_HEIGHT 38
#define TEXT_FIELD_FONT_SIZE 22
#define BUTTON_HEIGHT 40
#define HEIGHT 266
#define WIDTH 280
#define COLOUR_PICKER_HEIGHT 150
#define PADDING 16
#define BORDER_THICKNESS 1

@interface PPLLabelEditorView ()

@property PPLInsetTextField *textField;

@property UIControl *rotationControl;
@property PPLColourPickerView *colourPickerView;

@property UIButton *cancelButton;
@property UIButton *confirmButton;

@end

@implementation PPLLabelEditorView

@synthesize currentLabel = _currentLabel;

- (id) init {
  if (self = [super init]) {
    [self makeConstraints:^(MASConstraintMaker *make) {
      make.width.equalTo(@WIDTH);
      make.height.equalTo(@HEIGHT);
    }];
    
    NSArray *dogeStrings = @[@"wow",
                             @"wow",
                             @"wow",
                             @"such doge",
                             @"many label",
                             @"very interest",
                             @"doge approve",
                             @"much impress",
                             @"so picture"];
    
    self.textField = [[PPLInsetTextField alloc] init];
    self.textField.font = [UIFont fontWithName:DOGE_FONT_NAME size:TEXT_FIELD_FONT_SIZE];
    self.textField.textColor = DOGE_STEEL;
    self.textField.text = dogeStrings.sampleOne;
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.layer.cornerRadius = DOGE_CORNER_RADIUS;
    self.textField.edgeInsets = UIEdgeInsetsMake(0, EDGE_PADDING, 0, EDGE_PADDING);
    self.textField.returnKeyType = UIReturnKeyDone;
    self.textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    self.textField.clearsOnBeginEditing = YES;
    self.textField.delegate = self;
    [self addSubview:self.textField];
    [self.textField makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self).with.offset(EDGE_PADDING);
      make.left.equalTo(self).with.offset(EDGE_PADDING);
      make.right.equalTo(self).with.offset(-EDGE_PADDING);
      make.height.equalTo(@TEXT_FIELD_HEIGHT);
    }];
    
    self.colourPickerView = [[PPLColourPickerView alloc] init];
    [self addSubview:self.colourPickerView];
    [self.colourPickerView makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.textField.bottom).with.offset(PADDING);
      make.left.equalTo(self).with.offset(PADDING*2);
      make.right.equalTo(self).with.offset(-PADDING*2);
      make.height.equalTo(@COLOUR_PICKER_HEIGHT);
    }];
    
    NSString *cancelButtonText = NSLocalizedString(@"cancel", @"cancel button text");
    self.cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelButton setTitle:cancelButtonText forState:UIControlStateNormal];
    [self.cancelButton setTitleColor:DOGE_RED forState:UIControlStateNormal];
    [self addSubview:self.cancelButton];
    [self.cancelButton makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self);
      make.left.equalTo(self);
      make.width.equalTo(self).dividedBy(2.0);
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
    [self addSubview:self.confirmButton];
    [self.confirmButton makeConstraints:^(MASConstraintMaker *make) {
      make.bottom.equalTo(self);
      make.right.equalTo(self);
      make.width.equalTo(self).dividedBy(2.0);
      make.height.equalTo(@BUTTON_HEIGHT);
    }];
    [self.confirmButton addTarget:self
                           action:@selector(confirmButtonTapped:)
                 forControlEvents:UIControlEventTouchUpInside];
    
    UIView *buttonTopBorder = [[UIView alloc] init];
    buttonTopBorder.backgroundColor = [UIColor colorWithHue:1.000 saturation:0.005 brightness:0.824 alpha:1];
    [self addSubview:buttonTopBorder];
    [buttonTopBorder makeConstraints:^(MASConstraintMaker *make) {
      make.left.equalTo(self);
      make.right.equalTo(self);
      make.bottom.equalTo(self).with.offset(-BUTTON_HEIGHT);
      make.height.equalTo(@BORDER_THICKNESS);
    }];
    
    UIView *buttonMiddleBorder = [[UIView alloc] init];
    buttonMiddleBorder.backgroundColor = [UIColor colorWithHue:1.000 saturation:0.005 brightness:0.824 alpha:1];
    [self addSubview:buttonMiddleBorder];
    [buttonMiddleBorder makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.centerX);
      make.bottom.equalTo(self);
      make.height.equalTo(@BUTTON_HEIGHT);
      make.width.equalTo(@BORDER_THICKNESS);
    }];
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

- (void) setCurrentLabel:(PPLLabel *)currentLabel {
  _currentLabel = currentLabel;
  self.textField.text = currentLabel.text;
  [self.colourPickerView pickColour:currentLabel.color];
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
  [PPLTrackingHelper passCheckpoint:@"Changed Label Text"];
  
  [textField resignFirstResponder];
  return NO;
}


# pragma mark - Triggers

- (void) cancelButtonTapped:(id)sender {
  [PPLTrackingHelper passCheckpoint:@"Cancelled Editing Label"];
  
  [self.editorView dismissLabelEditorViewConfirmed:NO];
}

- (void) confirmButtonTapped:(id)sender {
  [PPLTrackingHelper passCheckpoint:@"Edited a Label"];
  
  self.currentLabel.text = self.textField.text;
  self.currentLabel.rotation = 0.0;
  self.currentLabel.color = self.colourPickerView.pickedColour;
  
  [self.editorView dismissLabelEditorViewConfirmed:YES];
}


@end
