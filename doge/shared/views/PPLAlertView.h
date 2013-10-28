//
//  PPLAlertView.h
//  doge
//
//  Created by Ben Taylor on 28/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PPLAlertViewDelegate <NSObject>

@optional

@end

@protocol PPLAlertViewDataSource <NSObject>

@optional

@end

@interface PPLAlertView : UIView

- (void) show;
- (void) dismiss;

- (void) showAnimated:(BOOL)animated;
- (void) dismissAnimated:(BOOL)animated;

@property (readonly) UIView *overlayView;
@property (readonly) UIView *containerView;
@property (nonatomic) UIView *containedView;

@end
