//
//  PPLLabelEditorView.h
//  doge
//
//  Created by Ben Taylor on 10/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLEditorView.h"

typedef enum {
  PPLLabelEditorViewConfigurationEdit,
  PPLLabelEditorViewConfigurationCreate
} PPLLabelEditorViewConfiguration;

@interface PPLLabelEditorView : UIView <UITextFieldDelegate>

- (id) initWithEditorView:(PPLEditorView *)editorView;
- (id) initWithEditorView:(PPLEditorView *)editorView configuration:(PPLLabelEditorViewConfiguration)configuration;

@property PPLEditorView *editorView;
@property (nonatomic) PPLLabelEditorViewConfiguration configuration;

@property (nonatomic) PPLLabel *currentLabel;

- (void) animateIn;
- (void) animateOut;

@end
