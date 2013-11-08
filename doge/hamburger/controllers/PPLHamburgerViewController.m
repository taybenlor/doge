//
//  PPLHamburgerViewController.m
//  doge
//
//  Created by Ben Taylor on 3/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLHamburgerViewController.h"

@interface PPLHamburgerViewController ()
@property UIView *menuContainerView;
@property UIView *mainContainerView;

@property id<MASConstraint> mainLeftConstraint;
@end

@implementation PPLHamburgerViewController

# pragma mark - Initializers

- (id) init {
  if (self = [super init]) {
    self.menuContainerView = [[UIView alloc] init];
    self.mainContainerView = [[UIView alloc] init];
    
    [self.view addSubview:self.menuContainerView];
    [self.view addSubview:self.mainContainerView];
    
    [self.mainContainerView makeConstraints:^(MASConstraintMaker *make) {
      make.top.equalTo(self.view.top);
      make.size.equalTo(self.view);
      self.mainLeftConstraint = make.left.equalTo(self.view.left);
    }];
    
    [self.menuContainerView makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.view);
    }];
  }
  return self;
}

- (id) initWithMain:(UIViewController *)mainController menu:(UIViewController *)menuController {
  if (self = [self init]) {
    _mainController = mainController;
    _menuController = menuController;
    
    [self addChildViewController:mainController];
    [self addChildViewController:menuController];
    
    [self.menuContainerView addSubview:self.menuController.view];
    [self.mainContainerView addSubview:self.mainController.view];
    
    [self.menuController.view makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.menuContainerView);
    }];
    
    [self.mainController.view makeConstraints:^(MASConstraintMaker *make) {
      make.edges.equalTo(self.mainContainerView);
    }];
  }
  return self;
}

# pragma mark - Public Methods


- (void) toggleIsOpenAnimated:(BOOL)animated {
  [self setIsOpen:!self.isOpen animated:animated];
}

- (void) setIsOpen:(BOOL)isOpen {
  [self setIsOpen:isOpen animated:NO];
}

- (void) setIsOpen:(BOOL)isOpen animated:(BOOL)animated {
  _isOpen = isOpen;
  
  if (isOpen) {
    self.mainLeftConstraint.offset(200);
  } else {
    self.mainLeftConstraint.offset(0);
  }
  
  // TODO: animate position of the status bar
  
  if (animated) {
    [UIView animateWithDuration:0.3 animations:^{
      [self.view layoutIfNeeded];
    }];
  } else {
    [self.view layoutIfNeeded];
  }
}

- (void) setMainController:(UIViewController *)mainController {
  [self setMainController:mainController animated:NO];
}

- (void) setMainController:(UIViewController *)mainController animated:(BOOL)animated {
  if (animated) {
    // Animate the transition
  } else {
    [self replaceContainedView:self.mainController.view withView:mainController.view];
  }
  
  [_mainController removeFromParentViewController];
  _mainController = mainController;
  [self addChildViewController:_mainController];
}

- (void) setMenuController:(UIViewController *)menuController {
  [self replaceContainedView:self.menuController.view withView:menuController.view];
  
  [self.menuController removeFromParentViewController];
  _menuController = menuController;
  [self addChildViewController:_menuController];
}

#pragma mark - Helper Methods

- (void) replaceContainedView:(UIView *)containedView withView:(UIView *)newView {
  UIView *superview = containedView.superview;
  [containedView removeFromSuperview];
  [superview addSubview:newView];
  [newView makeConstraints:^(MASConstraintMaker *make) {
    make.edges.equalTo(superview);
  }];
}

@end
