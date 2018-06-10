//
//  DetailViewController.m
//  Flix
//
//  Created by Chi Hwa Michael Ting on 6/3/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"
#import "UIKit+AFNetworking.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark #2 Code snippet for : https://guides.codepath.com/ios/Working-with-UIImageView#fading-in-an-image-loaded-from-the-network

- (void)viewDidLoad {
    [super viewDidLoad];
    
 #pragma mark #1 Code snippet for : https://guides.codepath.com/ios/Using-Modal-Transitions
    
    self.movieTitle.text = self.movie[@"title"];
    self.movieDescription.text = self.movie[@"overview"];
    
    NSURL *url = [NSURL URLWithString:@"https://image.tmdb.org/t/p/w500/j0BtDE8M4Q2sJANrQjCosU8N7ji.jpg"];
    
//    [self.imageView setImageWithURL:url];
#pragma mark #2 END
    
#pragma mark #3 Code snippet for : https://github.com/codepath/ios_guides/wiki/Working-with-UIImageView
    NSURL *urlSmall = [NSURL URLWithString:@"https://image.tmdb.org/t/p/w200/j0BtDE8M4Q2sJANrQjCosU8N7ji.jpg"];
    NSURL *urlLarge = [NSURL URLWithString:@"https://image.tmdb.org/t/p/w500/j0BtDE8M4Q2sJANrQjCosU8N7ji.jpg"];

    NSURLRequest *requestSmall = [NSURLRequest requestWithURL:urlSmall];
    NSURLRequest *requestLarge = [NSURLRequest requestWithURL:urlLarge];

    __weak DetailViewController *weakSelf = self;

    [self.imageView setImageWithURLRequest:requestSmall
                          placeholderImage:nil
                                   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *smallImage) {
                                       
                                       // smallImageResponse will be nil if the smallImage is already available
                                       // in cache (might want to do something smarter in that case).
                                       weakSelf.imageView.alpha = 0.0;
                                       weakSelf.imageView.image = smallImage;
                                       
                                       [UIView animateWithDuration:0.3
                                                        animations:^{
                                                            
                                                            weakSelf.imageView.alpha = 1.0;
                                                            
                                                        } completion:^(BOOL finished) {
                                                            // The AFNetworking ImageView Category only allows one request to be sent at a time
                                                            // per ImageView. This code must be in the completion block.
                                                            [weakSelf.imageView setImageWithURLRequest:requestLarge
                                                                                  placeholderImage:smallImage
                                                                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage * largeImage) {
                                                                                                weakSelf.imageView.image = largeImage;
                                                                                  }
                                                                                           failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                                                                               // do something for the failure condition of the large image request
                                                                                               // possibly setting the ImageView's image to a default image
                                                                                           }];
                                                        }];
                                   }
                                   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
                                       // do something for the failure condition
                                       // possibly try to get the large image
                                   }];
    
#pragma mark #3 END
    
    
    
#pragma mark #4 Code snippet for : https://github.com/codepath/ios_guides/wiki/Navigation-Controller

//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Save"
//                                                                              style:UIBarButtonItemStylePlain
//                                                                             target:self action:@selector(saveButtonTapped:)];
//    UILabel *titleLabel = [UILabel new];
//
//    NSShadow *shadow = [NSShadow new];
//    shadow.shadowColor = [[UIColor grayColor] colorWithAlphaComponent:0.5];
//    shadow.shadowOffset = CGSizeMake(2, 2);
//    shadow.shadowBlurRadius = 4;
//
//    NSAttributedString *titleText = [[NSAttributedString alloc] initWithString:@"Edit Name"
//                                                                    attributes:@{NSFontAttributeName : [UIFont boldSystemFontOfSize:28],
//                                                                                 NSForegroundColorAttributeName : [UIColor colorWithRed:0.5 green:0.25 blue:0.15 alpha:0.8],
//                                                                                 NSShadowAttributeName : shadow}];
//
//    titleLabel.attributedText = titleText;
//    [titleLabel sizeToFit];
//    self.navigationItem.titleView = titleLabel;

    
//    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save"
//                                                                              style:UIBarButtonItemStylePlain
//                                                                             target:self action:@selector(saveButtonTapped:)];
//    
//    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Foo", @"Bar"]];
//    [segmentedControl sizeToFit];
//    UIBarButtonItem *segmentedButton = [[UIBarButtonItem alloc] initWithCustomView:segmentedControl];
//    
//    UIBarButtonItem *dummyButton = [[UIBarButtonItem alloc] initWithTitle:@"Dummy" style:UIBarButtonItemStylePlain target:nil action:nil];
//    
//    self.navigationItem.rightBarButtonItems = @[saveButton, segmentedButton];
//    self.navigationItem.leftBarButtonItem = dummyButton;
    
    
    
    
#pragma mark #4 END

}

- (void)saveButtonTapped:(id)sender {
    NSLog(@"SaveButtonTapped:");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)imageTapped:(UITapGestureRecognizer *)sender {
    
    

    
//    [self performSegueWithIdentifier:@"showWebVC" sender:nil];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    WebViewController *webVC = [storyboard instantiateViewControllerWithIdentifier:@"WebVC"];

    [self presentViewController:webVC animated:YES completion:nil];
 
#pragma mark END #1

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
