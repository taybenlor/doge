//
//  PPLLabelContainerView.h
//  doge
//
//  Created by Ben Taylor on 16/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PPLLabel.h"
#import "PPLEditorLabel.h"

@class PPLLabelContainerView;
@protocol PPLLabelContainerViewDataSource <NSObject>

- (NSSet *) labelsForLabelContainerView:(PPLLabelContainerView *)labelContainerView;

@end

@protocol PPLLabelContainerViewDelegate <NSObject>

@optional

- (void) labelContainerView:(PPLLabelContainerView *)labelContainerView didSelectLabel:(PPLLabel *)label;
- (void) labelContainerView:(PPLLabelContainerView *)labelContainerView didDeselectLabel:(PPLLabel *)label;
- (void) labelContainerView:(PPLLabelContainerView *)labelContainerView didTriggerEditOnLabel:(PPLLabel *)label;
- (void) labelContainerViewDidTriggerNewLabel:(PPLLabelContainerView *)labelContainerView;

@end


@interface PPLLabelContainerView : UIView <PPLEditorLabelDelegate>

@property (weak, nonatomic) id<PPLLabelContainerViewDataSource> dataSource;
@property (weak, nonatomic) id<PPLLabelContainerViewDelegate> delegate;

- (void) reloadData;

@end
