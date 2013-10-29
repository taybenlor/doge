//
//  PPLAlertView.m
//  doge
//
//  Created by Ben Taylor on 29/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLAlertView.h"

#define PADDING 22
#define WIDTH 270
#define BUTTON_HEIGHT 44

@interface PPLAlertView ()

@property (nonatomic) NSMutableArray *internalButtonTitles;
@property NSArray *buttons;

@property UILabel *titleLabel;
@property UILabel *messageLabel;

@end

@implementation PPLAlertView

- (instancetype) init {
  if (self = [super init]) {
    // Do things?
  }
  return self;
}

- (instancetype) initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<PPLAlertViewDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ... {
  NSMutableArray *buttonTitles = [NSMutableArray arrayWithArray:@[cancelButtonTitle]];
  va_list args;
  va_start(args, otherButtonTitles);
  for (NSString *buttonTitle = otherButtonTitles; buttonTitle != nil; buttonTitle = va_arg(args, NSString*)) {
    [buttonTitles addObject:buttonTitle];
  }
  va_end(args);
  
  return [self initWithTitle:title message:message delegate:delegate buttonTitles:buttonTitles];
}

- (instancetype) initWithTitle:(NSString *)title message:(NSString *)message delegate:(id<PPLAlertViewDelegate>)delegate buttonTitles:(NSArray *)buttonTitles {
  if (self = [self init]) {
    self.title = title;
    self.message = message;
    self.delegate = delegate;
    self.buttonTitles = buttonTitles;
  }
  return self;
}


# pragma mark - Actions

- (void) buttonTapped:(UIButton *)button {
  NSUInteger index = [self.buttons indexOfObject:button];
  [self dismissWithClickedButtonIndex:index animated:YES];
}


# pragma mark - Construct Views

- (void) constructViews {
  self.containedView = [[UIView alloc] init];
  
  [self.containedView makeConstraints:^(MASConstraintMaker *make) {
    make.width.equalTo(@WIDTH);
  }];
  
  if (self.title) {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = self.title;
    self.titleLabel.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:17.0];
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.containedView addSubview:self.titleLabel];
    
    [self.titleLabel makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.containedView.top).with.offset(PADDING);
      make.left.equalTo(self.containedView.left).with.offset(PADDING);
      make.right.equalTo(self.containedView.right).with.offset(-PADDING);
    }];
    [self.titleLabel sizeToFit];
  }
  
  if (self.message) {
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.text = self.message;
    self.messageLabel.font = [UIFont systemFontOfSize:14.0];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.textAlignment = NSTextAlignmentCenter;
    
    [self.containedView addSubview:self.messageLabel];
    
    [self.messageLabel makeConstraints:^(MASConstraintMaker *make) {
      if (self.titleLabel) {
        make.top.equalTo(self.titleLabel.bottom).with.offset(PADDING/3);
      } else {
        make.top.equalTo(self.containedView.top).with.offset(PADDING);
      }
      
      make.left.equalTo(self.containedView.left).with.offset(PADDING);
      make.right.equalTo(self.containedView.right).with.offset(-PADDING);
    }];
    [self.messageLabel sizeToFit];
  }
  
  MASViewAttribute *topAttribute;
  if (self.messageLabel) {
    topAttribute = self.messageLabel.bottom;
  } else if (self.titleLabel) {
    topAttribute = self.titleLabel.bottom;
  } else {
    topAttribute = self.messageLabel.top;
  }
  
  NSMutableArray *buttons = [NSMutableArray array];
  UIButton *previousButton = nil;
  for (NSString *buttonTitle in self.buttonTitles) {
    BOOL isLastButton = [buttonTitle isEqual:self.buttonTitles.lastObject];
    UIButton *button = [[UIButton alloc] init];
    button.tintColor = DOGE_RED;
    [button setTitleColor:DOGE_RED forState:UIControlStateNormal];
    [button setTitle:buttonTitle forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    [self.containedView addSubview:button];
    
    if (isLastButton) {
      button.titleLabel.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    }
    
    [button makeConstraints:^(MASConstraintMaker *make) {
      make.height.equalTo(@BUTTON_HEIGHT);
      
      if (self.buttonTitles.count > 2) {
        make.left.equalTo(self.containedView.left);
        make.right.equalTo(self.containedView.right);
        
        if (previousButton) {
          make.top.equalTo(previousButton.bottom);
        } else {
          make.top.equalTo(topAttribute).with.offset(PADDING);
        }
      } else {
        make.width.equalTo(@(WIDTH/2));
        make.top.equalTo(topAttribute).with.offset(PADDING);
        
        if (previousButton) {
          make.left.equalTo(previousButton.right);
        } else {
          make.left.equalTo(self.containedView);
        }
      }
      
      if ([buttonTitle isEqual:self.buttonTitles.lastObject]) {
        make.bottom.equalTo(self.containedView);
      }
    }];
    
    if (self.buttonTitles.count == 1 || !isLastButton) {
      UIView *buttonLine = [[UIView alloc] init];
      buttonLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
      [self.containedView addSubview:buttonLine];
      
      [buttonLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.top);
        make.left.equalTo(self.containedView);
        make.right.equalTo(self.containedView);
        make.height.equalTo(@0.5);
      }];
    }
    
    if (self.buttonTitles.count == 2 && isLastButton) {
      UIView *buttonLine = [[UIView alloc] init];
      buttonLine.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
      [self.containedView addSubview:buttonLine];
      
      [buttonLine makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(button.top).with.offset(0.5);
        make.bottom.equalTo(self.containedView);
        make.width.equalTo(@0.5);
        make.left.equalTo(button);
      }];
    }
    
    previousButton = button;
    [buttons addObject:button];
  }
  
  self.buttons = buttons;
}


# pragma mark - Displaying Alert View

- (void) show {
  [self showAnimated:YES];
}

- (void) showAnimated:(BOOL)animated {
  [self showAnimated:animated completion:nil];
}

- (void) showAnimated:(BOOL)animated completion:(PPLCustomAlertViewCompletionBlock)completionBlock {
  [self constructViews];
  
  if ([self.delegate respondsToSelector:@selector(willPresentAlertView:)]) {
    [self.delegate willPresentAlertView:self];
  }
  
  [super showAnimated:animated completion:^{
    if ([self.delegate respondsToSelector:@selector(didPresentAlertView:)]) {
      [self.delegate didPresentAlertView:self];
    }
    
    if (completionBlock) {
      completionBlock();
    }
  }];
}

- (void) showWithDismissHandler:(PPLAlertViewDismissBlock)dismissBlock {
  self.dismissBlock = dismissBlock;
  [self show];
}

- (void) dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
  if (buttonIndex == 0 && [self.delegate respondsToSelector:@selector(alertViewCancel:)]) {
    [self.delegate alertViewCancel:self];
  }
  
  if ([self.delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
    [self.delegate alertView:self willDismissWithButtonIndex:buttonIndex];
  }
  
  [self dismissAnimated:animated completion:^{
    if (self.dismissBlock) self.dismissBlock(buttonIndex);
    
    if ([self.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
      [self.delegate alertView:self didDismissWithButtonIndex:buttonIndex];
    }
  }];
}


# pragma mark - Buttons

- (NSInteger) addButtonWithTitle:(NSString *) title {
  [self.internalButtonTitles addObject:title];
  return 0;
}

- (NSString *) buttonTitleAtIndex:(NSInteger) buttonIndex {
  return self.buttonTitles[buttonIndex];
}


# pragma mark - Properties

- (void) setButtonTitles:(NSArray *)buttonTitles {
  self.internalButtonTitles = [NSMutableArray arrayWithArray:buttonTitles];
}

- (NSArray *) buttonTitles {
  return self.internalButtonTitles;
}

- (NSMutableArray *) internalButtonTitles {
  if (_internalButtonTitles) return _internalButtonTitles;
  return _internalButtonTitles = [NSMutableArray array];
}


@end
