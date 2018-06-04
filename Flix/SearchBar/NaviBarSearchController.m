//
//  NaviBarSearchController.m
//  Flix
//
//  Created by Chi Hwa Michael Ting on 5/31/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import "NaviBarSearchController.h"

@interface NaviBarSearchController ()

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSArray *filteredData;
@property (strong, nonatomic) UISearchBar *searchBar;

@end

@implementation NaviBarSearchController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    // create the search bar programatically since you won't be
    // able to drag one onto the navigation bar
    self.searchBar = [[UISearchBar alloc] init];
    [self.searchBar sizeToFit];
    
    // the UIViewController comes with a navigationItem property
    // this will automatically be initialized for you if when the
    // view controller is added to a navigation controller's stack
    // you just need to set the titleView to be the search bar
    self.navigationItem.titleView = self.searchBar;
    
    self.searchBar.delegate = self;
    
    self.data = @[@"New York, NY", @"Los Angeles, CA", @"Chicago, IL", @"Houston, TX",
                  @"Philadelphia, PA", @"Phoenix, AZ", @"San Diego, CA", @"San Antonio, TX",
                  @"Dallas, TX", @"Detroit, MI", @"San Jose, CA", @"Indianapolis, IN",
                  @"Jacksonville, FL", @"San Francisco, CA", @"Columbus, OH", @"Austin, TX",
                  @"Memphis, TN", @"Baltimore, MD", @"Charlotte, ND", @"Fort Worth, TX"];
    self.filteredData = self.data;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
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

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    
    if (searchText.length != 0) {
        
        NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
            return [evaluatedObject containsString:searchText];
        }];
        self.filteredData = [self.data filteredArrayUsingPredicate:predicate];
        
        NSLog(@"%@", self.filteredData);
        
    }
    else {
        self.filteredData = self.data;
    }
    
    [self.tableView reloadData];
    
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = YES;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchBar.showsCancelButton = NO;
    self.searchBar.text = @"";
    [self.searchBar resignFirstResponder];
}

@end
