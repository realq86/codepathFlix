//
//  WebViewController.m
//  Flix
//
//  Created by Chi Hwa Michael Ting on 6/3/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@end

@implementation WebViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    #pragma mark #2 Code snippet for : https://github.com/codepath/ios_guides/wiki/Using-WebKit-View/
    
    NSString *urlString = @"https://www.dropbox.com/terms?mobile=1";
    
    // Convert the url String to a NSURL object.
    NSURL *url = [NSURL URLWithString:urlString];

    // Place the URL in a URL Request.
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:10.0];
    
    // Load Request into WebView.
    [self.webkitView loadRequest:request];
#pragma mark #2 END
    

#pragma mark #4 Code snippet for : https://guides.codepath.com/ios/Using-Gesture-Recognizers
    // Here we use the method didPan(sender:), which we defined in the previous step, as the action.
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTap:)];
    
    // Optionally set the number of required taps, e.g., 2 for a double click
    tapGestureRecognizer.numberOfTapsRequired = 2;
    
    // Attach it to a view of your choice. If it's a UIImageView, remember to enable user interaction
    [self.view setUserInteractionEnabled:YES];
    [self.view addGestureRecognizer:tapGestureRecognizer];
#pragma mark #4 END
    
    
    self.navigationItem.title = @"Names";

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark #3 Code snippet for : https://guides.codepath.com/ios/Using-Gesture-Recognizers
- (IBAction)didTap:(UITapGestureRecognizer *)sender {
    
    CGPoint location = [sender locationInView:self.view];
    
#pragma mark #1 Code snippet for : https://guides.codepath.com/ios/Using-Modal-Transitions
    [self dismissViewControllerAnimated:YES completion:nil];
#pragma mark #1 END
}
#pragma mark #3 END

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
