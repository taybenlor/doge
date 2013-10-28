//
//  PPLLabelContainerView.m
//  doge
//
//  Created by Ben Taylor on 16/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLLabelContainerView.h"

@interface PPLLabelContainerView()

@property (nonatomic)  NSMutableArray *editorLabels;

@property PPLEditorLabel *selectedLabel;
@property UITapGestureRecognizer *doubleTapRecognizer;
@property UITapGestureRecognizer *singleTapRecognizer;

@end

@implementation PPLLabelContainerView

- (instancetype) init {
  if (self = [super init]) {
    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
    self.doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped)];
    self.doubleTapRecognizer.numberOfTapsRequired = 2;
    [self addGestureRecognizer:self.doubleTapRecognizer];
    
    self.singleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped)];
    self.singleTapRecognizer.numberOfTapsRequired = 1;
    [self addGestureRecognizer:self.singleTapRecognizer];
  }
  return self;
}


#pragma mark - Public Methods

- (void) reloadData {
  PPLLabel *label = self.selectedLabel.label;
  self.selectedLabel = nil;
  if (label) {
    [self.delegate labelContainerView:self didDeselectLabel:label];
  }
  
  for (PPLEditorLabel *label in self.editorLabels) {
    [label removeFromSuperview];
  }
  
  NSUInteger count = self.editorLabels.count;
  
  self.editorLabels = [NSMutableArray array];
  for (PPLLabel *label in [self.dataSource labelsForLabelContainerView:self]) {
    PPLEditorLabel *editorLabel = [[PPLEditorLabel alloc] initWithLabel:label];
    editorLabel.delegate = self;
    [self addSubview:editorLabel];
    [editorLabel updateAttributes];
    
    [self.editorLabels addObject:editorLabel];
  }
  
  if (self.editorLabels.count > count) {
    [self selectEditorLabel:self.editorLabels.lastObject];
  }
}


#pragma mark - EditorLabelDelegate

- (void) editorLabelDidTriggerEdit:(PPLEditorLabel *)editorLabel {
  if ([self.delegate respondsToSelector:@selector(labelContainerView:didTriggerEditOnLabel:)]) {
    [self.delegate labelContainerView:self didTriggerEditOnLabel:editorLabel.label];
  }
}

- (void) editorLabelWasSelected:(PPLEditorLabel *)selectedEditorLabel {
  [self selectEditorLabel:selectedEditorLabel];
}


#pragma mark - Private Methods

- (void) selectEditorLabel:(PPLEditorLabel *)editorLabel {
  self.editorLabels.each(^(PPLEditorLabel *editorLabel){
    editorLabel.editing = NO;
  });
  
  editorLabel.editing = YES;
  self.selectedLabel = editorLabel;
  
  if ([self.delegate respondsToSelector:@selector(labelContainerView:didSelectLabel:)]) {
    [self.delegate labelContainerView:self didSelectLabel:editorLabel.label];
  }
}

- (void) deselectCurrentEditorLabel {
  PPLEditorLabel *currentLabel = self.selectedLabel;
  self.selectedLabel.editing = NO;
  self.selectedLabel = nil;
  if ([self.delegate respondsToSelector:@selector(labelContainerView:didDeselectLabel:)]) {
    [self.delegate labelContainerView:self didDeselectLabel:currentLabel.label];
  }
}


#pragma mark - Actions

- (void) doubleTapped {
  if ([self.delegate respondsToSelector:@selector(labelContainerViewDidTriggerNewLabel:)]) {
    [self.delegate labelContainerViewDidTriggerNewLabel:self];
  }
}

- (void) singleTapped {
  [self deselectCurrentEditorLabel];
}


#pragma mark - Properties

- (void) setDataSource:(id<PPLLabelContainerViewDataSource>)dataSource {
  _dataSource = dataSource;
  [self reloadData];
}

- (NSMutableArray *) editorLabels {
  if (_editorLabels) return _editorLabels;
  return _editorLabels = [NSMutableArray array];
}

@end
