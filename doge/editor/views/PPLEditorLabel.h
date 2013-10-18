//
//  PPLLabelView.h
//  doge
//
//  Created by Ben Taylor on 12/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLLabel.h"

@interface PPLEditorLabel : UILabel

- (id) initWithLabel:(PPLLabel *)label;

@property (nonatomic) PPLLabel *label;
@property (nonatomic) BOOL editing;

- (void) updateAttributes;

@end
