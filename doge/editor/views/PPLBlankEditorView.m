//
//  PPLBlankEditorView.m
//  doge
//
//  Created by Ben Taylor on 3/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLBlankEditorView.h"

#define PADDING 40

@interface PPLBlankEditorView ()

@property UIButton *choosePhotoButton;

@end

@implementation PPLBlankEditorView

- (id) init {
  if (self = [super init]) {
    self.backgroundColor = DOGE_STEEL;
    
    UIImage *normalChoosePhotoButton = [UIImage imageNamed:@"choose-photo-button"];
    UIImage *highlightedChoosePhotoButton = [UIImage imageNamed:@"choose-photo-button_highlighted"];
    
    self.choosePhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.choosePhotoButton.accessibilityLabel = @"Choose photo";
    [self.choosePhotoButton setImage:normalChoosePhotoButton forState:UIControlStateNormal];
    [self.choosePhotoButton setImage:highlightedChoosePhotoButton forState:UIControlStateHighlighted];
    
    [self addSubview:self.choosePhotoButton];
    
    [self.choosePhotoButton makeConstraints:^(MASConstraintMaker *make) {
      make.center.equalTo(self);
    }];
  }
  return self;
}

- (id) initWithController:(PPLBlankEditorViewController *)controller {
  if (self = [self init]) {
    [self.choosePhotoButton addTarget:self.controller
                               action:@selector(choosePhotoButtonTapped:)
                     forControlEvents:UIControlEventTouchUpInside];
  }
  return self;
}

@end
