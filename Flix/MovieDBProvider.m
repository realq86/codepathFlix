//
//  MovieDBProvider.m
//  Flix
//
//  Created by Chi Hwa Michael Ting on 5/20/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import "MovieDBProvider.h"

@interface MovieDBProvider()
@property (nonatomic, strong) NSURLSession *urlSession;
@end


@implementation MovieDBProvider

NSString *const apiURL = @"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed";


+(instancetype) shared {
    
    static MovieDBProvider *provider = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        provider = [[self alloc] init];
        
        
        provider.urlSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]
                                                            delegate:nil
                                                       delegateQueue:[NSOperationQueue mainQueue]];
        
    });
    
    
    return provider;
}

#pragma mark #4 Code snippet for: https://github.com/codepath/ios_guides/wiki/Network-Programming

- (void)getNowPlaying:(void(^)(NSDictionary *))completion {

    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
    
    NSURL *URL = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDataTask *dataTask = [manager dataTaskWithRequest:request
                                                   uploadProgress:nil
                                                 downloadProgress:nil
                                                completionHandler:^(NSURLResponse *response, id  responseObject, NSError *error) {
                                                        if (error) {
                                                            NSLog(@"Error: %@", error);
                                                        } else {
                                                            NSLog(@"%@ %@", response, responseObject);
                                                            NSDictionary *dataDictionary = responseObject;
                                                            completion(dataDictionary);
                                                        }
                                                }];
    [dataTask resume];
}
#pragma mark #4 END



@end
