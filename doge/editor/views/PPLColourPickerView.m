//
//  PPLColourPickerView.m
//  doge
//
//  Created by Ben Taylor on 17/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLColourPickerView.h"

#define BUTTON_DIAMETER 32
#define PADDING 14
#define UNSELECTED_BORDER 6
#define SELECTED_BORDER 2

@interface PPLColourPickerView()

@property (nonatomic) NSArray *colours;
@property (nonatomic) NSMutableArray *colourButtons;

@end

@implementation PPLColourPickerView

- (instancetype) init {
  if (self = [super init]) {
    for (int i = 0; i < self.colours.count; i++) {
      UIColor *colour = self.colours[i];
      UIButton *colourButton = [UIButton buttonWithType:UIButtonTypeCustom];
      colourButton.backgroundColor = colour;
      colourButton.layer.borderColor = [UIColor colorWithHue:0.000 saturation:0.000 brightness:0.843 alpha:1].CGColor;
      colourButton.layer.borderWidth = UNSELECTED_BORDER;
      colourButton.layer.cornerRadius = BUTTON_DIAMETER/2;
      [colourButton addTarget:self action:@selector(colourButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
      [self addSubview:colourButton];
      [colourButton makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@BUTTON_DIAMETER);
        make.height.equalTo(@BUTTON_DIAMETER);
        
        if (i % 3 == 0) { // left edge
          make.left.equalTo(self);
        } else if (i % 3 == 1) { // center
          make.centerX.equalTo(self.mas_centerX);
        } else if (i % 3 == 2) { // right edge
          make.right.equalTo(self);
        }
        
        int row = i/3;
        CGFloat topOffset = (BUTTON_DIAMETER + PADDING) * row;
        make.top.equalTo(self).with.offset(topOffset);
      }];
      [self.colourButtons addObject:colourButton];
    }
    
    UIButton *colourButton = self.colourButtons.sampleOne;
    colourButton.layer.borderWidth = 2.0;
    colourButton.selected = YES;
  }
  return self;
}


#pragma mark - Public Methods

- (UIColor *) pickedColour {
  for (UIButton *button in self.colourButtons) {
    if (button.selected) {
      return button.backgroundColor;
    }
  }
  return DOGE_RED;
}

- (void) pickColour:(UIColor *)colour {
  for (UIButton *colourButton in self.colourButtons) {
    colourButton.selected = NO;
    colourButton.layer.borderWidth = UNSELECTED_BORDER;
  }
  
  for (UIButton *colourButton in self.colourButtons) {
    if ([colourButton.backgroundColor isEqual:colour]) {
      colourButton.selected = YES;
      colourButton.layer.borderWidth = SELECTED_BORDER;
    }
  }
}


#pragma mark - Actions

- (void) colourButtonTapped:(UIButton *)sender {
  for (UIButton *colourButton in self.colourButtons) {
    colourButton.selected = NO;
    colourButton.layer.borderWidth = UNSELECTED_BORDER;
  }
  
  sender.selected = YES;
  sender.layer.borderWidth = SELECTED_BORDER;
  if ([self.delegate respondsToSelector:@selector(colourPickerView:didSelectColour:)]) {
    [self.delegate colourPickerView:self didSelectColour:sender.backgroundColor];
  }
}


#pragma mark - Properties

- (NSArray *) colours {
  if (_colours) return _colours;
  return _colours = @[
    [UIColor colorWithHue:0.332 saturation:0.727 brightness:0.906 alpha:1],
    [UIColor colorWithHue:0.756 saturation:0.651 brightness:1.000 alpha:1],
    [UIColor colorWithHue:1.000 saturation:0.651 brightness:1.000 alpha:1],
    [UIColor colorWithHue:0.171 saturation:0.651 brightness:1.000 alpha:1],
    [UIColor colorWithHue:0.087 saturation:0.651 brightness:1.000 alpha:1],
    [UIColor colorWithHue:0.906 saturation:0.651 brightness:1.000 alpha:1],
    [UIColor colorWithHue:0.000 saturation:0.000 brightness:0.000 alpha:1],
    [UIColor colorWithHue:0.000 saturation:0.000 brightness:1.000 alpha:1],
    [UIColor colorWithHue:0.600 saturation:0.651 brightness:1.000 alpha:1]
  ];
}

- (NSMutableArray *) colourButtons {
  if (_colourButtons) return _colourButtons;
  return _colourButtons = [NSMutableArray array];
}



@end
