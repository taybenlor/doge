//
//  PPLImage.h
//  doge
//
//  Created by Ben Taylor on 3/11/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PPLImage : NSObject

@property NSString *imagePath;
@property NSArray *labels;

- (UIImage *) renderedImage;

@end
