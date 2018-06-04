//
//  DetailViewController.h
//  Flix
//
//  Created by Chi Hwa Michael Ting on 6/3/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UIGestureRecognizerDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@property (strong, nonatomic) IBOutlet UILabel *movieTitle;

@property (strong, nonatomic) IBOutlet UILabel *movieDescription;

@property(strong, nonatomic) NSDictionary *movie;

@end
