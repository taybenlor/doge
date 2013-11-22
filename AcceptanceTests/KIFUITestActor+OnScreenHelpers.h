//
//  KIFUITestActor+OnScreenHelpers.h
//  doge
//
//  Created by Ben Taylor on 22/11/2013.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "KIFUITestActor.h"

@interface KIFUITestActor (OnScreenHelpers)

- (void) waitForOffscreenViewWithAccessibilityLabel:(NSString *)accessibilityLabel;
- (void) waitForOffscreenViewWithAccessibilityLabel:(NSString *)label traits:(UIAccessibilityTraits)traits;
- (void) waitForOffscreenViewWithAccessibilityLabel:(NSString *)label value:(NSString *)value traits:(UIAccessibilityTraits)traits;

- (void) waitForOnscreenViewWithAccessibilityLabel:(NSString *)accessibilityLabel;
- (void) waitForOnscreenViewWithAccessibilityLabel:(NSString *)label traits:(UIAccessibilityTraits)traits;
- (void) waitForOnscreenViewWithAccessibilityLabel:(NSString *)label value:(NSString *)value traits:(UIAccessibilityTraits)traits;

@end
