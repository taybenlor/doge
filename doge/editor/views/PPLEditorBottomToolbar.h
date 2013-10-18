//
//  PPLEditorBottomToolbar.h
//  doge
//
//  Created by Ben Taylor on 8/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLEditorView.h"

@interface PPLEditorBottomToolbar : UIToolbar

- (id) initWithEditorView:(PPLEditorView *)editorView;

@property PPLEditorView *editorView;

@end
