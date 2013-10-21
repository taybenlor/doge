//
//  PPLEditorViewController.h
//  doge
//
//  Created by Ben Taylor on 4/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLLabel.h"

@interface PPLEditorViewController : UIViewController

- (id) initWithImage:(UIImage *)image;

@property UIImage *image;
@property PPLLabel *selectedLabel;

- (NSMutableSet *) labels;
- (void) addOrUpdateLabel:(PPLLabel *)label;

# pragma mark - Triggerable Events

- (void) addLabelTriggered;
- (void) addDogeTriggered;
- (void) shareDogeTriggered;

- (void) selectLabelTriggered:(PPLLabel *)label;

- (void) editLabelTriggered;
- (void) increaseLabelSizeTriggered;
- (void) decreaseLabelSizeTriggered;
- (void) deleteLabelTriggered;

@end
