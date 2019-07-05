//
//  AYMovieController.m
//  Assessment4
//
//  Created by Albert Yu on 7/5/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

#import "AYMovieController.h"

@implementation AYMovieController

static NSString * const baseURLString = @"https://api.themoviedb.org/3/search/movie";
static NSString * const query = @"query";
static NSString * const apiKey = @"api_key";
static NSString * const apiKeyValue = @"1dcb93f9ada4b5a7449077216e36134f";
static NSString * const imageURL = @"https://image.tmdb.org/t/p/w500";

+(instancetype) sharedInstance
{
    static AYMovieController *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [AYMovieController new];
    });
    return sharedInstance;
}

-(void) fetchMovies:(NSString *)searchTerm completion:(void (^)(NSArray<AYMovie *> *))completion {
    NSURL *baseURL = [NSURL URLWithString: baseURLString];
    NSURLQueryItem *api = [[NSURLQueryItem alloc] initWithName: apiKey value: apiKeyValue];
    NSURLQueryItem *search  = [[NSURLQueryItem alloc] initWithName: query value: searchTerm];
    NSURLComponents *components = [NSURLComponents componentsWithURL: baseURL resolvingAgainstBaseURL: TRUE];
    components.queryItems = [[NSArray alloc] initWithObjects: (api),(search), nil];
    NSURL *finalURL = [components URL];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:finalURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        if (data) {
            NSDictionary * JSONTopDictionary = [NSJSONSerialization JSONObjectWithData: data options:2 error:&error];
            if (!JSONTopDictionary) {
                NSLog(@"Error JSONTopDictionary");
                completion(nil);
                return;
            }
            NSMutableArray *moviesArray = [NSMutableArray new];
            for (NSDictionary *movieDictionary in JSONTopDictionary[@"results"]) {
                AYMovie *movie = [[AYMovie alloc] initWithDictionary:movieDictionary];
                [moviesArray addObject:movie];
            }
            completion(moviesArray);
        }
    }]resume];
}

-(void) fetchPoster: (AYMovie *)movie completion: (void (^)(UIImage * _Nullable))completion {
    NSURL *baseURL = [NSURL URLWithString:imageURL];
    if ([[movie posterPath] isKindOfClass:[NSNull class]]) {
        completion(nil);
        return;
    }
    NSURL *fullURL = [baseURL URLByAppendingPathComponent: [movie posterPath]];
    [[[NSURLSession sharedSession] dataTaskWithURL:fullURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error.localizedDescription);
            completion(nil);
            return;
        }
        
        UIImage *moviePosterImage = [UIImage imageWithData:data];
        completion(moviePosterImage);
    }] resume];
}

@end
