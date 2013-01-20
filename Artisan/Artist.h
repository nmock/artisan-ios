//
//  Artist.h
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artist : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong) NSString *biography;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSArray *mixes;

- (id)initWithArtistName:(NSString *)artistName;
@end
