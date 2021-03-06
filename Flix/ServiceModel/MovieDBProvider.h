//
//  MovieDBProvider.h
//  Flix
//
//  Created by Chi Hwa Michael Ting on 5/20/18.
//  Copyright © 2018 CodePath. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@interface MovieDBProvider : NSObject


+ (instancetype)shared;

- (void)getNowPlaying:(void(^)(NSDictionary *, NSError *error))completion;
@end
