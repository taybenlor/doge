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

@property PPLEditorLabel *draggingLabel;
@property CGPoint lastTouchLocation;

@end

@implementation PPLLabelContainerView

- (instancetype) init {
  if (self = [super init]) {
    self.clipsToBounds = YES;
    self.userInteractionEnabled = YES;
  }
  return self;
}


#pragma mark - Public Methods

- (void) reloadData {
  for (PPLEditorLabel *label in self.editorLabels) {
    [label removeFromSuperview];
  }
  
  self.editorLabels = [NSMutableArray array];
  for (PPLLabel *label in [self.dataSource labelsForLabelContainerView:self]) {
    PPLEditorLabel *editorLabel = [[PPLEditorLabel alloc] initWithLabel:label];
    editorLabel.delegate = self;
    [self addSubview:editorLabel];
    [editorLabel updateAttributes];
    
    [self.editorLabels addObject:editorLabel];
  }
}


#pragma mark - EditorLabelDelegate

- (void) editorLabelDidTriggerEdit:(PPLEditorLabel *)editorLabel {
  if ([self.delegate respondsToSelector:@selector(labelContainerView:didTriggerEditOnLabel:)]) {
    [self.delegate labelContainerView:self didTriggerEditOnLabel:editorLabel.label];
  }
}


#pragma mark - Private Methods

- (void) selectEditorLabel:(PPLEditorLabel *)editorLabel {
  editorLabel.editing = YES;
  self.draggingLabel = editorLabel;
  
  if ([self.delegate respondsToSelector:@selector(labelContainerView:didSelectLabel:)]) {
    [self.delegate labelContainerView:self didSelectLabel:editorLabel.label];
  }
}

- (void) deselectCurrentEditorLabel {
  PPLEditorLabel *currentLabel = self.draggingLabel;
  self.draggingLabel = nil;
  if ([self.delegate respondsToSelector:@selector(labelContainerView:didDeselectLabel:)]) {
    [self.delegate labelContainerView:self didDeselectLabel:currentLabel.label];
  }
}


#pragma mark - Touch Events

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if (touches.count > 1) return;
  
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  
  self.editorLabels.each(^(PPLEditorLabel *editorLabel){
    editorLabel.editing = NO;
  });
  
  for (PPLEditorLabel *editorLabel in self.editorLabels) {
    if (CGRectContainsPoint(editorLabel.frame, location)) {
      self.lastTouchLocation = location;
      [self selectEditorLabel:editorLabel];
      return;
    }
  }
  
  [self deselectCurrentEditorLabel];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  if (!self.draggingLabel) return;
  
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  CGFloat diffX = (location.x - self.lastTouchLocation.x)/self.frame.size.width;
  CGFloat diffY = (location.y - self.lastTouchLocation.y)/self.frame.size.height;
  CGPoint labelPos = self.draggingLabel.label.position;
  CGFloat newX = MIN(MAX(labelPos.x + diffX, -0.15), 0.9);
  CGFloat newY = MIN(MAX(labelPos.y + diffY, -0.15), 0.9);
  CGPoint newPos = CGPointMake(newX, newY);
  self.draggingLabel.label.position = newPos;
  [self layoutIfNeeded];
  
  self.lastTouchLocation = location;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
  
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
