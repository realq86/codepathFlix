//
//  MovieCell.m
//  Flix
//
//  Created by Chi Hwa Michael Ting on 5/22/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import "MovieCell.h"
#import "UIKit+AFNetworking.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMovie:(NSDictionary *)movie {
    _movie = movie;
        
#pragma mark #1 Code snippet for : https://guides.codepath.com/ios/Working-with-UIImageView#loading-a-low-resolution-image-followed-by-a-high-resolution-image
    NSString *urlString = [NSString stringWithFormat:@"https://image.tmdb.org/t/p/w500/%@", self.movie[@"poster_path"]];
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];

    __weak MovieCell *weakSelf = self;
    [self.movieImage setImageWithURLRequest:request placeholderImage:nil
                                    success:^(NSURLRequest *imageRequest, NSHTTPURLResponse *imageResponse, UIImage *image) {
                                        
                                        // imageResponse will be nil if the image is cached
                                        if (imageResponse) {
                                            NSLog(@"Image was NOT cached, fade in image");
                                            weakSelf.movieImage.alpha = 0.0;
                                            weakSelf.movieImage.image = image;
                                            
                                            //Animate UIImageView back to alpha 1 over 0.3sec
                                            [UIView animateWithDuration:0.3 animations:^{
                                                weakSelf.movieImage.alpha = 1.0;
                                            }];
                                        }
                                        else {
                                            NSLog(@"Image was cached so just update the image");
                                            weakSelf.movieImage.image = image;
                                        }
                                    }
                                    failure:^(NSURLRequest *request, NSHTTPURLResponse * response, NSError *error) {
                                        // do something for the failure condition
                                    }];
    
#pragma mark #1 END
}

@end
