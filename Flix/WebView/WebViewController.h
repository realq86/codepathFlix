//
//  WebViewController.h
//  Flix
//
//  Created by Chi Hwa Michael Ting on 6/3/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WKWebView.h>

@interface WebViewController : UIViewController

@property (strong, nonatomic) IBOutlet WKWebView *webkitView;

@end
