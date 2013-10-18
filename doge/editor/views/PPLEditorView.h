//
//  PPLEditorView.h
//  doge
//
//  Created by Ben Taylor on 4/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLEditorViewController.h"
#import "PPLLabelContainerView.h"

@interface PPLEditorView : UIView <PPLLabelContainerViewDataSource>

@property (nonatomic) PPLEditorViewController *controller;

- (id) initWithController:(PPLEditorViewController *)controller;

- (void) presentLabelEditorView;
- (void) presentLabelEditorViewWithLabel:(PPLLabel *)label;
- (void) dismissLabelEditorViewConfirmed:(BOOL)confirmed;

- (void) updateLabels;
@end
