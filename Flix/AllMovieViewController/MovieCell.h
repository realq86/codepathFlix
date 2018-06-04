//
//  MovieCell.h
//  Flix
//
//  Created by Chi Hwa Michael Ting on 5/22/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MovieCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *movieImage;
@property (strong, nonatomic) IBOutlet UILabel *movieTitle;
@property (strong, nonatomic) IBOutlet UILabel *movieDescription;

@property (strong, nonatomic) NSDictionary *movie;

@end
