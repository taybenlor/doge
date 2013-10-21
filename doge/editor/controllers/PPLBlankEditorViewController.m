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

@end

@implementation PPLBlankEditorViewController

- (id) init {
  if (self = [super init]) {
    self.view = [[PPLBlankEditorView alloc] initWithController:self];
    self.navigationItem.title = @"instadoge";
  }
  return self;
}

- (void) viewDidLoad {
  [super viewDidLoad];
}


#pragma mark - Private Methods

- (void) openImagePicker {
#if TARGET_IPHONE_SIMULATOR
  [self pickedImage:[UIImage imageNamed:@"demo.jpg"]];
  return;
#endif
  
  UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
  imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
  imagePickerController.mediaTypes = @[(NSString *)kUTTypeImage];
  imagePickerController.delegate = self;
  imagePickerController.allowsEditing = NO;
  
  [self.navigationController presentViewController:imagePickerController animated:YES completion:nil];
  [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void) pickedImage:(UIImage *)image {
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
