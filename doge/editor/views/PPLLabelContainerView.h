//
//  PPLLabelContainerView.h
//  doge
//
//  Created by Ben Taylor on 16/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PPLLabelContainerView;
@protocol PPLLabelContainerViewDataSource <NSObject>

- (NSSet *) labelsForLabelContainerView:(PPLLabelContainerView *)labelContainerView;

@end


@interface PPLLabelContainerView : UIView

@property (weak, nonatomic) id<PPLLabelContainerViewDataSource> dataSource;

- (void) reloadData;

@end
