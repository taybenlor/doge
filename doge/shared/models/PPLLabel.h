//
//  PPLLabel.h
//  doge
//
//  Created by Ben Taylor on 7/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPLLabel : NSObject

@property NSString *text;
@property UIColor *color;
@property CGFloat rotation;
@property CGPoint position;
@property CGFloat fontSize;

- (void) increaseFontSize;
- (void) decreaseFontSize;

@end
