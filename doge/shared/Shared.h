//
//  Shared.h
//  doge
//
//  Created by Ben Taylor on 3/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#ifndef doge_Shared_h
#define doge_Shared_h

#define TESTFLIGHT_ON 0
#define LOCALYTICS_ON 1

#define TESTFLIGHT_KEY @"86ed787e-5f62-49a0-a6c9-2fc05c76a695"

#define LOCALYTICS_TESTING_KEY @"de31fa8adc507305732e91e-0ebdaa3c-4173-11e3-3d71-00a426b17dd8"
#define LOCALYTICS_PRODUCTION_KEY @"26e0fb83f07579c89603294-cf7a92f8-4170-11e3-3d71-00a426b17dd8"
#define LOCALYTICS_KEY @"26e0fb83f07579c89603294-cf7a92f8-4170-11e3-3d71-00a426b17dd8"

// Use Masonry in shorthand mode
#define MAS_SHORTHAND
#import "Masonry.h"

#import "EnumeratorKit.h"

#import "NSArray+Sampling.h"

#import <TargetConditionals.h>

#if TESTFLIGHT_ON
#import "TestFlight.h"
#endif

#if LOCALYTICS_ON
#import "LocalyticsSession.h"
#endif

#import "PPLTrackingHelper.h"
#import "UIViewController+Hamburger.h"

#define DOGE_RED [UIColor colorWithRed:0.7890625 green:0.31640625 blue:0.31640625 alpha:1]
#define DOGE_STEEL [UIColor colorWithHue:0.625 saturation:0.235 brightness:0.267 alpha:1]
#define DOGE_STEEL_DARK [UIColor colorWithHue:0.625 saturation:0.250 brightness:0.188 alpha:1]

#define DOGE_FONT_NAME @"ChalkboardSE-Bold"

#define DOGE_CORNER_RADIUS 3.0


#define DISPLAY_IMAGE_WIDTH 300
#define DISPLAY_IMAGE_HEIGHT 300
#define OUTPUT_IMAGE_WIDTH 640
#define OUTPUT_IMAGE_HEIGHT 640

typedef void(^PPLCallback)(void);

#endif
