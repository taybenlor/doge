//
//  PPLEditorTests.m
//  doge
//
//  Created by Ben Taylor on 22/11/2013.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import <KIF/KIF.h>
#import "KIFUITestActor+NavigationHelpers.h"
#import "KIFUITestActor+OnScreenHelpers.h"

@interface PPLEditorTests : KIFTestCase

@end

@implementation PPLEditorTests

- (void) beforeEach {
  [tester pickPhoto];
}

- (void) afterEach {
  [tester newPhoto];
}

- (void) testAddDogeTextModal {
  [tester tapViewWithAccessibilityLabel:@"Add doge text"];
  [tester waitForViewWithAccessibilityLabel:@"Label editor"];
  [tester tapViewWithAccessibilityLabel:@"Cancel"];
}

- (void) addDogeLabelWithText:(NSString *)text {
  [tester tapViewWithAccessibilityLabel:@"Add doge text"];
  [tester waitForViewWithAccessibilityLabel:@"Label editor"];
  [tester enterText:text intoViewWithAccessibilityLabel:@"Doge text field"];
  [tester tapViewWithAccessibilityLabel:@"done"];
  [tester tapViewWithAccessibilityLabel:@"Add"];
  [tester waitForViewWithAccessibilityLabel:text];
}

- (void) testAddDogeLabel {
  [self addDogeLabelWithText:@"such test"];
}

- (void) testToolbarOpensAfterTextAdded {
  [self testAddDogeLabel];
  
  [tester waitForOnscreenViewWithAccessibilityLabel:@"Bottom toolbar"];
}

- (void) testEditLabelFromBottomToolbar {
  [self testAddDogeLabel];
  
  [tester tapViewWithAccessibilityLabel:@"Edit selected doge text"];
  [tester waitForViewWithAccessibilityLabel:@"Label editor"];
  [tester tapViewWithAccessibilityLabel:@"Cancel"];
}

- (void) testDeleteLabelFromBottomToolbar {
  [self testAddDogeLabel];
  
  [tester tapViewWithAccessibilityLabel:@"Delete selected doge text"];
  [tester waitForTappableViewWithAccessibilityLabel:@"Delete"];
  [tester tapViewWithAccessibilityLabel:@"Delete"];
  [tester waitForAbsenceOfViewWithAccessibilityLabel:@"such test"];
}

- (void) testMoveLabel {
  [self testAddDogeLabel];
  
  [tester swipeViewWithAccessibilityLabel:@"such test" inDirection:KIFSwipeDirectionRight];
  [tester waitForOffscreenViewWithAccessibilityLabel:@"such test"];
}

- (void) testAddTwoLabels {
  [self addDogeLabelWithText:@"such test one"];
  [self addDogeLabelWithText:@"such test two"];
}

- (void) testAddTwoLabelsSecondSelected {
  [self testAddTwoLabels];
  
  [tester tapViewWithAccessibilityLabel:@"Edit selected doge text"];
  [tester waitForViewWithAccessibilityLabel:@"Label editor"];
  // u[tester waitForViewWithAccessibilityLabel:@"Doge text field" value:@"such test two" traits:UIAccessibilityTraitNone];
  [tester tapViewWithAccessibilityLabel:@"Cancel"];
}

- (void) testEditingUpdatesLabel {
  [self testAddDogeLabel];
  
  [tester tapViewWithAccessibilityLabel:@"Edit selected doge text"];
  [tester enterText:@"such edit" intoViewWithAccessibilityLabel:@"Doge text field"];
  [tester tapViewWithAccessibilityLabel:@"done"];
  [tester tapViewWithAccessibilityLabel:@"Update"];
  [tester waitForViewWithAccessibilityLabel:@"such edit"];
}

- (void) testSharingShowsShareSheet {
  [tester tapViewWithAccessibilityLabel:@"Share doge"];
  [tester waitForViewWithAccessibilityLabel:@"Cancel"];
  [tester tapViewWithAccessibilityLabel:@"Cancel"];
}

@end
