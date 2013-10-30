//
//  PPLBlankEditorViewController.m
//  doge
//
//  Created by Ben Taylor on 3/10/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLBlankEditorViewController.h"
#import "PPLBlankEditorView.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "PPLEditorViewController.h"

@interface PPLBlankEditorViewController ()
@property UIImagePickerController *imagePickerController;
@end

@implementation PPLBlankEditorViewController

- (id) init {
  if (self = [super init]) {
    self.view = [[PPLBlankEditorView alloc] initWithController:self];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app-title"]];

    self.imagePickerController = [[UIImagePickerController alloc] init];
    self.imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    self.imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
    self.imagePickerController.delegate = self;
    self.imagePickerController.allowsEditing = NO;
  }
  return self;
}


#pragma mark - Private Methods

- (void) openImagePicker {
  [PPLTrackingHelper passCheckpoint:@"Open Image Picker"];
  
#if TARGET_IPHONE_SIMULATOR
  [self pickedImage:[UIImage imageNamed:@"demo.jpg"]];
  return;
#endif
  
  [UINavigationBar appearance].tintColor = DOGE_RED;
  
  [self.navigationController presentViewController:self.imagePickerController animated:YES completion:nil];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void) pickedImage:(UIImage *)image {
  [PPLTrackingHelper passCheckpoint:@"Picked An Image"];
  
  [UINavigationBar appearance].tintColor = [UIColor whiteColor];
  [self.navigationController dismissViewControllerAnimated:YES completion:nil];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
  
  PPLEditorViewController *editorController = [[PPLEditorViewController alloc] initWithImage:image];
  [self.navigationController setViewControllers:@[editorController] animated:NO];
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
  UIImage *pickedImage = info[UIImagePickerControllerOriginalImage];
  
  [self pickedImage:pickedImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
  [self.navigationController dismissViewControllerAnimated:YES completion:nil];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
}


#pragma mark - Actions

- (void) choosePhotoButtonTapped:(id)target {
  [self openImagePicker];
}

@end
