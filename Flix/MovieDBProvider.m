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
- (void)getNowPlaying:(void(^)(NSDictionary *))completion {
    
    NSURL *url = [NSURL URLWithString:apiURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:10.0];

    NSURLSessionDataTask *task = [self.urlSession dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                    
            if (error != nil) {
                NSLog(@"%@", [error localizedDescription]);
            }
            else {
                
                NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                               options:NSJSONReadingMutableContainers
                                                                                 error:nil];
                
                completion(dataDictionary);
                
                NSLog(@"%@", dataDictionary);
            }
                                                    
    }];
    
    [task resume];

    
}

//- (instancetype)init {
//
//    if (self = [super init] ) {
//
//    }
//
//
//}



@end
