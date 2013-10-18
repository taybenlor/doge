//
//  PPLHamburgerViewController.h
//  doge
//
//  Created by Ben Taylor on 3/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PPLHamburgerViewController : UIViewController

@property (nonatomic) UIViewController *mainController;
@property (nonatomic) UIViewController *menuController;
@property (nonatomic) BOOL isOpen;

- (id) initWithMain:(UIViewController *)mainController menu:(UIViewController *)menuController;

- (void) setIsOpen:(BOOL)isOpen animated:(BOOL)animated;
- (void) setMainController:(UIViewController *)mainController animated:(BOOL)animated;


@end
