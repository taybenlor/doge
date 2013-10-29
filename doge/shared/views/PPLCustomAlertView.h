//
//  PPLCustomAlertView.h
//  doge
//
//  Created by Ben Taylor on 28/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^PPLCustomAlertViewCompletionBlock)(void);
@interface PPLCustomAlertView : UIView

- (void) show;
- (void) dismiss;

- (void) showAnimated:(BOOL)animated;
- (void) showAnimated:(BOOL)animated completion:(PPLCustomAlertViewCompletionBlock)completionBlock;

- (void) dismissAnimated:(BOOL)animated;
- (void) dismissAnimated:(BOOL)animated completion:(PPLCustomAlertViewCompletionBlock)completionBlock;

@property (readonly) UIView *overlayView;
@property (readonly) UIView *containerView;
@property (nonatomic) UIView *containedView;

@end
