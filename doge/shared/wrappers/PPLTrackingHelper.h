//
//  PPLTrackingHelper.h
//  doge
//
//  Created by Ben Taylor on 31/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPLTrackingHelper : NSObject

+ (void) startTracking;
+ (void) resumeTracking;
+ (void) endTracking;
+ (void) passCheckpoint:(NSString *)checkpointName;

@end
