//
//  UISearchViewController.m
//  Flix
//
//  Created by Chi Hwa Michael Ting on 5/29/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#pragma mark #1 Code snippet for : https://github.com/codepath/ios_guides/wiki/Search-Bar-Guide

#import "UISearchViewController.h"

@interface UISearchViewController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *filteredData;

@end

@implementation UISearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.data = @[@"New York, NY", @"Los Angeles, CA", @"Chicago, IL", @"Houston, TX",
                  @"Philadelphia, PA", @"Phoenix, AZ", @"San Diego, CA", @"San Antonio, TX",
                  @"Dallas, TX", @"Detroit, MI", @"San Jose, CA", @"Indianapolis, IN",
                  @"Jacksonville, FL", @"San Francisco, CA", @"Columbus, OH", @"Austin, TX",
                  @"Memphis, TN", @"Baltimore, MD", @"Charlotte, ND", @"Fort Worth, TX"];
    self.filteredData = self.data;
    
    // Initializing with searchResultsController set to nil means that
    // searchController will use this view controller to display the search results
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    
    // If we are using this same view controller to present the results
    // dimming it out wouldn't make sense. Should probably only set
    // this to yes if using another controller to display the search results.
    self.searchController.dimsBackgroundDuringPresentation = NO;
    
    [self.searchController.searchBar sizeToFit];
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    // Sets this view controller as presenting view controller for the search interface
    self.definesPresentationContext = YES;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.filteredData.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:@"TableCell"
                                                                 forIndexPath:indexPath];
    cell.textLabel.text = self.filteredData[indexPath.row];
    return cell;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {
    
    NSString *searchText = searchController.searchBar.text;
    if (searchText) {
        
        if (searchText.length != 0) {
            NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
                return [evaluatedObject containsString:searchText];
            }];
            self.filteredData = [self.data filteredArrayUsingPredicate:predicate];
        }
        else {
            self.filteredData = self.data;
        }
        
        [self.tableView reloadData];
        
    }

}

@end

#pragma mark #1 END
