//
//  Shared.h
//  doge
//
//  Created by Ben Taylor on 3/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#ifndef doge_Shared_h
#define doge_Shared_h

// Use Masonry in shorthand mode
#define MAS_SHORTHAND
#import "Masonry.h"

#import "EnumeratorKit.h"

#import "NSArray+Sampling.h"

#import <TargetConditionals.h>

#import "TestFlight.h"

#define DOGE_RED [UIColor colorWithHue:1.000 saturation:0.599 brightness:0.792 alpha:1]
#define DOGE_STEEL [UIColor colorWithHue:0.625 saturation:0.235 brightness:0.267 alpha:1]

#define DOGE_FONT_NAME @"ChalkboardSE-Bold"

#define DOGE_CORNER_RADIUS 3.0


#define DISPLAY_IMAGE_WIDTH 300
#define DISPLAY_IMAGE_HEIGHT 300
#define OUTPUT_IMAGE_WIDTH 640
#define OUTPUT_IMAGE_HEIGHT 640

typedef void(^PPLCallback)(void);

#endif
