//
//  PPLHistoryViewController.m
//  doge
//
//  Created by Ben Taylor on 3/11/13.
//  Copyright (c) 2013 Pepper Labs. All rights reserved.
//

#import "PPLHistoryViewController.h"
#import "PPLHistoryCell.h"

static NSString *HistoryCellIdentifier = @"PPLHistoryCell";

@interface PPLHistoryViewController ()

@end

@implementation PPLHistoryViewController

- (id) init {
  if (self = [super initWithStyle:UITableViewStylePlain]) {
    self.view.backgroundColor = DOGE_STEEL_DARK;
  }
  return self;
}


#pragma mark - Table view data source

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 8;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  PPLHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:HistoryCellIdentifier];
  
  if (!cell) {
    cell = [[PPLHistoryCell alloc] init];
  }
  
  cell.dogeImage = [[PPLImage alloc] init];
  return cell;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
  return 200.0f;
}

@end
