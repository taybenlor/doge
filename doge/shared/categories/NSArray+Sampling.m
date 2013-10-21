//
//  NSArray+Sampling.m
//  doge
//
//  Created by Ben Taylor on 20/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "NSArray+Sampling.h"

@implementation NSArray (Sampling)

- (NSArray *) sample:(NSUInteger)number {
  NSMutableArray *copiedArray = [NSMutableArray arrayWithArray:self];
  NSMutableArray *outputArray = [NSMutableArray array];
  
  for (int i = 0; i < number; i++) {
    NSUInteger r = arc4random_uniform(copiedArray.count);
    id obj = copiedArray[r];
    [outputArray addObject:obj];
    [copiedArray removeObjectAtIndex:r];
  }
  
  return outputArray;
}

- (id) sampleOne {
  return [[self sample:1] firstObject];
}

@end
