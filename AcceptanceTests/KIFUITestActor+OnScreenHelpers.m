//
//  KIFUITestActor+OnScreenHelpers.m
//  doge
//
//  Created by Ben Taylor on 22/11/2013.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "KIFUITestActor+OnScreenHelpers.h"

#import "UIApplication-KIFAdditions.h"
#import "UIWindow-KIFAdditions.h"
#import "UIAccessibilityElement-KIFAdditions.h"
#import "UIView-KIFAdditions.h"
#import "CGGeometry-KIFAdditions.h"
#import "NSError-KIFAdditions.h"
#import "KIFTypist.h"
#import "UIView+ScreenPositionHelpers.h"

@implementation KIFUITestActor (OnScreenHelpers)

- (void)waitForOffscreenViewWithAccessibilityLabel:(NSString *)label {
  [self waitForOffscreenViewWithAccessibilityLabel:label traits:UIAccessibilityTraitNone];
}

- (void)waitForOffscreenViewWithAccessibilityLabel:(NSString *)label traits:(UIAccessibilityTraits)traits {
  [self waitForOffscreenViewWithAccessibilityLabel:label value:nil traits:traits];
}

- (void)waitForOffscreenViewWithAccessibilityLabel:(NSString *)label value:(NSString *)value traits:(UIAccessibilityTraits)traits {
  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
  CGRect windowFrame = window.bounds;
  
  [self runBlock:^KIFTestStepResult(NSError **error) {
    // If the app is ignoring interaction events, then wait before doing our analysis
    KIFTestWaitCondition(![[UIApplication sharedApplication] isIgnoringInteractionEvents], error, @"Application is ignoring interaction events.");
    
    UIAccessibilityElement *element = [[UIApplication sharedApplication] accessibilityElementWithLabel:label accessibilityValue:value traits:traits];
  
    UIView *view = [UIAccessibilityElement viewContainingAccessibilityElement:element];

    CGRect viewFrame = view.frame;
    viewFrame.origin = view.originOffsetFromRootView;
    
    KIFTestWaitCondition(!CGRectContainsRect(windowFrame, viewFrame), error, @"Accessibility element with label \"%@\" is within bounds of the window.", label);
    
    return KIFTestStepResultSuccess;
  }];
}

- (void)waitForOnscreenViewWithAccessibilityLabel:(NSString *)label {
  [self waitForOnscreenViewWithAccessibilityLabel:label traits:UIAccessibilityTraitNone];
}

- (void)waitForOnscreenViewWithAccessibilityLabel:(NSString *)label traits:(UIAccessibilityTraits)traits {
  [self waitForOnscreenViewWithAccessibilityLabel:label value:nil traits:traits];
}

- (void)waitForOnscreenViewWithAccessibilityLabel:(NSString *)label value:(NSString *)value traits:(UIAccessibilityTraits)traits {
  UIWindow *window = [[UIApplication sharedApplication] keyWindow];
  CGRect windowFrame = window.bounds;
  
  [self runBlock:^KIFTestStepResult(NSError **error) {
    // If the app is ignoring interaction events, then wait before doing our analysis
    KIFTestWaitCondition(![[UIApplication sharedApplication] isIgnoringInteractionEvents], error, @"Application is ignoring interaction events.");
    
    UIAccessibilityElement *element = [[UIApplication sharedApplication] accessibilityElementWithLabel:label accessibilityValue:value traits:traits];
    
    UIView *view = [UIAccessibilityElement viewContainingAccessibilityElement:element];
    
    CGRect viewFrame = view.frame;
    viewFrame.origin = view.originOffsetFromRootView;
    
    KIFTestWaitCondition(CGRectContainsRect(windowFrame, viewFrame), error, @"Accessibility element with label \"%@\" is within bounds of the window.", label);
    
    return KIFTestStepResultSuccess;
  }];
}

@end
