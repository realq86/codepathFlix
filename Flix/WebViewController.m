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
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)tapDismiss:(UITapGestureRecognizer *)sender {
    
#pragma mark #1 Code snippet for : https://guides.codepath.com/ios/Using-Modal-Transitions
    [self dismissViewControllerAnimated:YES completion:nil];
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
