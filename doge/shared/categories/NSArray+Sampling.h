//
//  NSArray+Sampling.h
//  doge
//
//  Created by Ben Taylor on 20/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSArray (Sampling)

- (NSArray *) sample:(NSUInteger)number;
- (id) sampleOne;

@end
