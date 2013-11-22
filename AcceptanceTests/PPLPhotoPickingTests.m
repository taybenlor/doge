//
//  PPLPhotoPickingTests.m
//  doge
//
//  Created by Ben Taylor on 22/11/2013.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <KIF/KIF.h>

@interface PPLPhotoPickingTests : KIFTestCase

@end

@implementation PPLPhotoPickingTests

- (void) beforeEach {
  
}

- (void) afterEach {
  
}

- (void) testSuccessfulPhotoPicking {
  // TODO: This test is kind of lame, because it's dependent on my simulator shortcut
  
  [tester tapViewWithAccessibilityLabel:@"Choose photo"];
  [tester waitForViewWithAccessibilityLabel:@"Photo editor"];
}

@end
