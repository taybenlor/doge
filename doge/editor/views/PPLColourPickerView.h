//
//  PPLColourPickerView.h
//  doge
//
//  Created by Ben Taylor on 17/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPLColourPickerView;
@protocol PPLColourPickerViewDelegate <NSObject>

- (void) colourPickerView:(PPLColourPickerView *)colourPickerView didSelectColour:(UIColor *)color;

@end

@interface PPLColourPickerView : UIView

@property id<PPLColourPickerViewDelegate> delegate;

- (UIColor *) pickedColour;

@end
