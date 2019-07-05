//
//  AYMovie.m
//  Assessment4
//
//  Created by Albert Yu on 7/5/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

#import "AYMovie.h"

@implementation AYMovie

-(instancetype) initWithTitle:(NSString *)title overview:(NSString *)overview rating:(NSNumber *)rating posterPath:(NSString *)posterPath {
    self = [super init];
    if (self) {
        _title = title;
    _overview = overview;
    _rating = rating;
    _posterPath = posterPath;
    }
    return self;
}

@end


@implementation AYMovie (JSONConvertible)

-(instancetype) initWithDictionary:(NSDictionary<NSString *,id> *)dictionary {
    NSString *movieTitle = dictionary[@"title"];
    NSString *overview= dictionary[@"overview"];
    NSNumber *rating = dictionary[@"vote_average"];
    NSString *posterPath = dictionary[@"poster_path"];
    return [self initWithTitle:movieTitle overview: overview rating:rating posterPath:posterPath];
}

@end
