//
//  PPLBlankEditorView.h
//  doge
//
//  Created by Ben Taylor on 3/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLBlankEditorViewController.h"

@interface PPLBlankEditorView : UIView

- (id) initWithController:(PPLBlankEditorViewController *) controller;

@property (weak) PPLBlankEditorViewController *controller;

@end
