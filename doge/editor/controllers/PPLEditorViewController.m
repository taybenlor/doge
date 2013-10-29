//
//  PPLEditorViewController.m
//  doge
//
//  Created by Ben Taylor on 4/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLEditorViewController.h"
#import "PPLLabel.h"
#import "PPLEditorView.h"
#import "PPLEditorLabel.h"
#import "UIAlertView+Blocks.h"
#import "PPLBlankEditorViewController.h"
#import "PPLAlertView.h"

@interface PPLEditorViewController ()
@property (nonatomic) NSMutableSet *labels;
@property PPLEditorView *view;
@end

@implementation PPLEditorViewController


#pragma mark - Lifecycle

- (id) init {
  if (self = [super init]) {
    self.view = [[PPLEditorView alloc] initWithController:self];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app-title"]];
    
    UIBarButtonItem *newDogeButton = [[UIBarButtonItem alloc] initWithTitle:@"new"
                                                        style:UIBarButtonItemStylePlain
                                                       target:self
                                                       action:@selector(newDogeTapped)];
    newDogeButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = newDogeButton;
    
    UIBarButtonItem *shareDogeButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"share-button"]
                                                                        style:UIBarButtonItemStylePlain
                                                                       target:self
                                                                       action:@selector(shareDogeTriggered)];
    shareDogeButton.tintColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = shareDogeButton;
  }
  return self;
}

- (id) initWithImage:(UIImage *)image {
  if (self = [self init]) {
    self.image = image;
  }
  return self;
}

- (void) viewDidLoad {
  [super viewDidLoad];
	// Do any additional setup after loading the view.
}


#pragma mark - Private Methods

- (void) share {
  [TestFlight passCheckpoint:@"Shared an Image"];
  UIImage *renderedImage = [self renderImage];
  
  UIActivityViewController *activityViewController = [[UIActivityViewController alloc] initWithActivityItems:@[renderedImage] applicationActivities:nil];
  [self.navigationController presentViewController:activityViewController animated:YES completion:nil];
  activityViewController.completionHandler = ^(NSString *activityType, BOOL completed) {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
  };
}

- (CGRect) imageRenderRect {
  if (self.image.size.width > self.image.size.height) {
    CGFloat width = (OUTPUT_IMAGE_HEIGHT / self.image.size.height) * self.image.size.width;
    CGFloat leftOffset = (width - OUTPUT_IMAGE_WIDTH)/2;
    NSLog(@"Wider width: %f, offset: %f", width, leftOffset);
    return CGRectMake(-leftOffset, 0, width, OUTPUT_IMAGE_HEIGHT);
  } else {
    
    CGFloat height = (OUTPUT_IMAGE_WIDTH / self.image.size.width) * self.image.size.height;

    CGFloat topOffset = (height - OUTPUT_IMAGE_HEIGHT)/2;
    NSLog(@"Taller height: %f, offset: %f", height, topOffset);
    return CGRectMake(0, -topOffset, OUTPUT_IMAGE_WIDTH, height);
  }
}

- (UIImage *) renderImage {
  CGSize size = CGSizeMake(OUTPUT_IMAGE_WIDTH, OUTPUT_IMAGE_HEIGHT);
  CGFloat resizeScale = OUTPUT_IMAGE_HEIGHT/((CGFloat)DISPLAY_IMAGE_HEIGHT);
  
  UIGraphicsBeginImageContext(size);
  
  [self.image drawInRect:self.imageRenderRect];
  
  for (PPLLabel *label in self.labels) {
    PPLEditorLabel *editorLabel = [[PPLEditorLabel alloc] initWithLabel:label];
    [editorLabel updateAttributes];
    editorLabel.font = [UIFont fontWithName:DOGE_FONT_NAME size:label.fontSize * resizeScale];
    [editorLabel sizeToFit];
    
    CGRect rect = CGRectMake(label.position.x * OUTPUT_IMAGE_WIDTH,
                             label.position.y * OUTPUT_IMAGE_HEIGHT,
                             editorLabel.bounds.size.width,
                             editorLabel.bounds.size.height);
    
    [editorLabel drawTextInRect:rect];
  }
  
  UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
  
  UIGraphicsEndImageContext();
  
  return renderedImage;
}


#pragma mark - Actions

- (void) newDogeTapped {
  [TestFlight passCheckpoint:@"Began Starting Again"];
  PPLAlertView *alertView = [[PPLAlertView alloc] init];
  alertView.title = NSLocalizedString(@"Trash this creation?", @"New creation alert view title");
  alertView.message = NSLocalizedString(@"Starting a new dogestagram will trash this stunning creation", @"New creation alert view descriptive message");
  [alertView addButtonWithTitle:NSLocalizedString(@"cancel", @"cancel")];
  [alertView addButtonWithTitle:NSLocalizedString(@"trash it", @"trash it and start a new one")];
  [alertView setTintColor:DOGE_RED];
  [alertView showWithDismissHandler:^(NSInteger buttonIndex) {
    if (buttonIndex) {
      [TestFlight passCheckpoint:@"Started Again"];
      [self transitionToBlankEditor];
    }
  }];
}


#pragma mark - Transition

- (void) transitionToBlankEditor {
  PPLBlankEditorViewController *blankEditorViewController = [[PPLBlankEditorViewController alloc] init];
  
  [self.view animateOut];
  
  [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
    self.navigationItem.leftBarButtonItem.tintColor = DOGE_RED; // fade them out
    self.navigationItem.rightBarButtonItem.tintColor = DOGE_RED;
  } completion:^(BOOL finished) {
    
  }];
  
  double delayInSeconds = 0.8;
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    [self.navigationController setViewControllers:@[blankEditorViewController] animated:NO];
  });
}


#pragma mark - Properties

- (NSMutableSet *) labels {
  if (_labels) return _labels;
  return _labels = [NSMutableSet set];
}


#pragma mark - Public Methods

- (void) addOrUpdateLabel:(PPLLabel *)label {
  [self.labels addObject:label];
  [self.view updateLabels];
}


#pragma mark - Triggerable Events

- (void) addLabelTriggered {
  [TestFlight passCheckpoint:@"Began Adding a Label"];
  [self.view presentLabelEditorView];
}

- (void) addDogeTriggered {
  NSLog(@"Do stuff to add a doge");
}

- (void) shareDogeTriggered {
  [self share];
}

- (void) selectLabelTriggered:(PPLLabel *)label {
  self.selectedLabel = label;
}

- (void) editLabelTriggered {
  [TestFlight passCheckpoint:@"Edited a Label"];
  [self.view presentLabelEditorViewWithLabel:self.selectedLabel];
}

- (void) increaseLabelSizeTriggered {
  [TestFlight passCheckpoint:@"Increased Label Size"];
  [self.selectedLabel increaseFontSize];
}

- (void) decreaseLabelSizeTriggered {
  [TestFlight passCheckpoint:@"Decreased Label Size"];
  [self.selectedLabel decreaseFontSize];
}

- (void) deleteLabelTriggered {
  [TestFlight passCheckpoint:@"Started Trashing a Label"];
  PPLAlertView *alertView = [[PPLAlertView alloc] init];
  NSString *alertViewTitle = NSLocalizedString(@"Delete \"%@\"?", @"Delete alert view text");
  alertView.title = [NSString stringWithFormat:alertViewTitle, self.selectedLabel.text];

  [alertView addButtonWithTitle:NSLocalizedString(@"cancel", @"cancel")];
  [alertView addButtonWithTitle:NSLocalizedString(@"delete", @"delete")];
  [alertView setTintColor:DOGE_RED];
  [alertView showWithDismissHandler:^(NSInteger buttonIndex) {
    if (buttonIndex) {
      [TestFlight passCheckpoint:@"Trashed a Label"];
      [self.labels removeObject:self.selectedLabel];
      [self.view updateLabels];
    }
  }];
}

@end
