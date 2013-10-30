//
//  PPLTrackingHelper.m
//  doge
//
//  Created by Ben Taylor on 31/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLTrackingHelper.h"

@implementation PPLTrackingHelper

+ (void) startTracking {
#if TESTFLIGHT_ON
  NSLog(@"Testflight is on, starting tracking");
  [TestFlight takeOff:TESTFLIGHT_KEY];
#endif

#if LOCALYTICS_ON
  NSLog(@"Localytics is on, starting tracking");
  [[LocalyticsSession shared] LocalyticsSession:LOCALYTICS_KEY];
  [PPLTrackingHelper resumeTracking];
#endif
}

+ (void) resumeTracking {
#if LOCALYTICS_ON
  [[LocalyticsSession shared] resume];
  [[LocalyticsSession shared] upload];
#endif
}

+ (void) endTracking {
#if LOCALYTICS_ON
  [[LocalyticsSession shared] close];
  [[LocalyticsSession shared] upload];
#endif
}

+ (void) passCheckpoint:(NSString *)checkpointName {
#if TESTFLIGHT_ON
  [TestFlight passCheckpoint:checkpointName];
#endif
  
#if LOCALYTICS_ON
  [[LocalyticsSession shared] tagEvent:@"Options Saved"];
#endif
}

@end
