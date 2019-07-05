//
//  AYMovie.h
//  Assessment4
//
//  Created by Albert Yu on 7/5/19.
//  Copyright © 2019 AlbertLLC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AYMovie : NSObject

@property(nonatomic, copy, readonly) NSString * title;
@property(nonatomic, copy, readonly, nullable) NSString * overview;
@property(nonatomic, copy, readonly, nullable) NSNumber * rating;
@property(nonatomic, copy, readonly, nullable) NSString * posterPath;

-(instancetype) initWithTitle:(NSString *) title overview: (NSString *) overview rating: (NSNumber *) rating posterPath: (NSString *) posterPath;

@end


@interface AYMovie (JSONConvertible)

- (instancetype) initWithDictionary:(NSDictionary<NSString *, id> *)dictionary;

@end


NS_ASSUME_NONNULL_END
