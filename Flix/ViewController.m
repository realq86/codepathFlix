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

@interface ViewController ()


@property (strong, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSArray *dataBackArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tableView.delegate = self;
    self.tableView.dataSource = self;

#pragma mark #2 Code snippet for : https://guides.codepath.com/ios/Table-View-Guide#adding-pull-to-refresh
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
#pragma mark #2 END

#pragma mark #3 Code snippet for: https://hackmd.io/2QgY35XMQFmgvGc3BbDrxQ?both
    // and : https://guides.codepath.com/ios/Table-View-Guide#adding-pull-to-refresh
//    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
//    NSURLRequest *request = [NSURLRequest requestWithURL:url
//                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
//                                         timeoutInterval:10.0];
//    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
//                                                          delegate:nil
//                                                     delegateQueue:[NSOperationQueue mainQueue]];
//    session.configuration.requestCachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//
//    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
//                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
//
//        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
//
//        if (error != nil) {
//            NSLog(@"%@", [error localizedDescription]);
//        }
//        else if (httpResponse.statusCode == 200 && data != nil){
//
//            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data
//                                                                           options:NSJSONReadingMutableContainers
//                                                                             error:&error];
//
//            if (error != nil) {
//                NSLog(@"%@", dataDictionary);
//                self.dataBackArray = dataDictionary[@"results"];
//                [self.tableView reloadData];
//            }
//        }
//
//    }];
//
//    [task resume];
#pragma mark #3 END
    
    
    //Using singleton to call instead of the snippet above
    MovieDBProvider *provider = MovieDBProvider.shared;
    [provider getNowPlaying:^(NSDictionary *response) {
        self.dataBackArray = response[@"results"];
        [self.tableView reloadData];
    }];
    
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
    
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
    
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else if (httpResponse.statusCode == 200 && data != nil){
    
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                               options:NSJSONReadingMutableContainers
                                                                                 error:&error];
    
                if (error != nil) {
                    NSLog(@"%@", dataDictionary);
                    self.dataBackArray = dataDictionary[@"results"];
                    [self.tableView reloadData];
                }
            }
    
        }];
    
        [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return self.dataBackArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MovieCell *movieCell = [self.tableView dequeueReusableCellWithIdentifier:@"MovieCell"
                                                           forIndexPath:indexPath];
    
    NSDictionary *movie = self.dataBackArray[indexPath.row];
    
    movieCell.movieTitle.text = (NSString *)movie[@"title"];
    
    movieCell.movieDescription.text = (NSString *)movie[@"overview"];
    
    return movieCell;
}


@end
