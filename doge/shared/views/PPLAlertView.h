//
//  PPLAlertView.h
//  doge
//
//  Created by Ben Taylor on 29/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLCustomAlertView.h"

typedef void(^PPLAlertViewDismissBlock)(NSInteger buttonIndex);

@class PPLAlertView;

@protocol PPLAlertViewDelegate <NSObject>

@optional

- (void)alertView:(PPLAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

- (BOOL)alertViewShouldEnableFirstOtherButton:(PPLAlertView *)alertView;

- (void)willPresentAlertView:(PPLAlertView *)alertView;
- (void)didPresentAlertView:(PPLAlertView *)alertView;

- (void)alertView:(PPLAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
- (void)alertView:(PPLAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

- (void)alertViewCancel:(PPLAlertView *)alertView;

@end

@interface PPLAlertView : PPLCustomAlertView

@property id<PPLAlertViewDelegate> delegate;

@property NSString *title;
@property NSString *message;
@property NSString *cancelButtonTitle;
@property (nonatomic) NSArray *buttonTitles;

@property (nonatomic, strong) PPLAlertViewDismissBlock dismissBlock;

@property (readonly) UILabel *titleLabel;
@property (readonly) UILabel *messageLabel;
@property (readonly) NSArray *buttons;

- (instancetype) initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<PPLAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...;
- (instancetype) initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<PPLAlertViewDelegate>)delegate buttonTitles:(NSArray *)buttonTitles;

- (NSInteger) addButtonWithTitle:(NSString *) title;
- (NSString *) buttonTitleAtIndex:(NSInteger) buttonIndex;

- (void) constructViews;

- (void) showWithDismissHandler:(PPLAlertViewDismissBlock) dismissBlock;

- (void) dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

@end
