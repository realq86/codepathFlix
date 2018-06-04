//
//  DetailViewController.m
//  Flix
//
//  Created by Chi Hwa Michael Ting on 6/3/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import "DetailViewController.h"
#import "WebViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
 #pragma mark #1 Code snippet for : https://guides.codepath.com/ios/Using-Modal-Transitions
    
    self.movieTitle.text = self.movie[@"title"];
    self.movieDescription.text = self.movie[@"overview"];
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
