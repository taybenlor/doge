//
//  PPLLabelContainerView.m
//  doge
//
//  Created by Ben Taylor on 16/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLLabelContainerView.h"
#import "PPLEditorLabel.h"

@interface PPLLabelContainerView()

@property (nonatomic)  NSMutableArray *editorLabels;

@property PPLEditorLabel *draggingLabel;
@property CGPoint lastTouchLocation;
//@property CGPoint dragOffset;

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
  for (PPLLabel *label in [self.dataSource labelsForLabelContainerView:self]) {
    BOOL exists = self.editorLabels.filter(^(PPLEditorLabel *editorLabel){
      return [editorLabel.label isEqual:label];
    }).count > 0;
    
    if (!exists) {
      PPLEditorLabel *editorLabel = [[PPLEditorLabel alloc] initWithLabel:label];
      [self addSubview:editorLabel];
      [editorLabel updateAttributes];
      
      [self.editorLabels addObject:editorLabel];
    }
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
  
  self.editorLabels.each(^(PPLEditorLabel *editorLabel){
    if (CGRectContainsPoint(editorLabel.frame, location)) {
      editorLabel.editing = YES;
      self.draggingLabel = editorLabel;
      self.lastTouchLocation = location;
    }
  });
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
  if (!self.draggingLabel) return;
  
  UITouch *touch = [touches anyObject];
  CGPoint location = [touch locationInView:self];
  CGFloat diffX = (location.x - self.lastTouchLocation.x)/self.frame.size.width;
  CGFloat diffY = (location.y - self.lastTouchLocation.y)/self.frame.size.height;
  CGPoint labelPos = self.draggingLabel.label.position;
  CGFloat newX = MIN(MAX(labelPos.x + diffX, 0), 1.0);
  CGFloat newY = MIN(MAX(labelPos.y + diffY, 0), 1.0);
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
