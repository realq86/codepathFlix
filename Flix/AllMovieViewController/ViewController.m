//
//  ViewController.m
//  Flix
//
//  Created by Chi Hwa Michael Ting on 5/20/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import "ViewController.h"
#import "MovieDBProvider.h"
#import "MovieCell.h"
#import "DetailViewController.h"

@interface ViewController ()


@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) NSArray *dataBackArray;
@property (strong, nonatomic) NSArray *filteredDataBackArray;


@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    self.searchBar.delegate = self;

#pragma mark #2 Code snippet for : https://guides.codepath.com/ios/Table-View-Guide#adding-pull-to-refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
#pragma mark #2 END

#pragma mark #3 Code snippet for: https://hackmd.io/2QgY35XMQFmgvGc3BbDrxQ?both
//     and : https://guides.codepath.com/ios/Table-View-Guide#adding-pull-to-refresh
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {

        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else if (httpResponse.statusCode == 200 && data != nil){

            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:&error];

            if (error == nil) {
                NSLog(@"%@", dataDictionary);
                self.dataBackArray = dataDictionary[@"results"];
                self.filteredDataBackArray = self.dataBackArray;
                [self.tableView reloadData];
            }
        }

    }];

    [task resume];
#pragma mark #3 END
//
//    [self.activityIndicator startAnimating];
//
//    //Using singleton to call instead of the snippet above
//    MovieDBProvider *provider = MovieDBProvider.shared;
//    [provider getNowPlaying:^(NSDictionary *response, NSError *error) {
//
//        if (error) {
//
#pragma mark #4 Code snippet for: https://github.com/codepath/ios_guides/wiki/Using-UIAlertController
//            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title"
//                                                                           message:@"Message"
//                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
//
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
//                                                                style:UIAlertActionStyleCancel
//                                                              handler:^(UIAlertAction * _Nonnull action) {
//
//                                                              }];
//
//            [alert addAction:cancelAction];
//
//            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
//                                                               style:UIAlertActionStyleDefault
//                                                             handler:^(UIAlertAction * _Nonnull action) {
//
//                                                             }];
//
//            [alert addAction:okAction];
//
//            [self presentViewController:alert animated:YES completion:^{
//
//            }];
//
//            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alert
//                                                                                         animated:YES
//                                                                                       completion:^{
//
//                                                                                       }];
#pragma mark #4 END
//
//        }
//        else {
//            self.dataBackArray = response[@"results"];
//            [self.tableView reloadData];
//        }
//
//
//        [self.activityIndicator stopAnimating];
//    }];
//
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                          delegate:nil
                                                     delegateQueue:[NSOperationQueue mainQueue]];
    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;

    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        [refreshControl endRefreshing];
                                                
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;

        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }
        else if (httpResponse.statusCode == 200 && data != nil){

            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                           options:NSJSONReadingMutableContainers
                                                                             error:&error];

            if (error == nil) {
                NSLog(@"%@", dataDictionary);
                self.dataBackArray = dataDictionary[@"results"];
                self.filteredDataBackArray = self.dataBackArray;
                [self.tableView reloadData];
            }
        }

    }];

    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.filteredDataBackArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *movieCell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieCell"
                                                           forIndexPath:indexPath];
    
    NSDictionary *movie = self.filteredDataBackArray[indexPath.row];
    
    movieCell.movie = movie;
    
    movieCell.movieTitle.text = (NSString *)movie[@"title"];
    
    movieCell.movieDescription.text = (NSString *)movie[@"overview"];
    
    return movieCell;
}

#pragma mark #1 Code snippet for : https://guides.codepath.com/ios/Using-Modal-Transitions
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    MovieCell *cell = (MovieCell *)sender;
    
    NSDictionary *movie = cell.movie;
    
    DetailViewController *detailVC = segue.destinationViewController;
    
    detailVC.movie = movie;
}

#pragma mark #1 END

@end
