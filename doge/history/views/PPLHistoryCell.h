//
//  PPLHistoryCell.h
//  doge
//
//  Created by Ben Taylor on 3/11/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLImage.h"

@interface PPLHistoryCell : UITableViewCell

@property (nonatomic) PPLImage *dogeImage;

+ (CGFloat) cellHeight;

@end
