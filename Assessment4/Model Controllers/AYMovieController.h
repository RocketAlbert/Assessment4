//
//  AYMovieController.h
//  Assessment4
//
//  Created by Albert Yu on 7/5/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AYMovie.h"


NS_ASSUME_NONNULL_BEGIN

@interface AYMovieController : NSObject

+(instancetype) sharedInstance;
-(void) fetchMovies: (NSString *) searchTerm completion: (void (^) (NSArray<AYMovie *> * movies)) completion;
-(void) fetchPoster: (AYMovie *) movie completion: (void (^) (UIImage * _Nullable image)) completion;

@end

NS_ASSUME_NONNULL_END
