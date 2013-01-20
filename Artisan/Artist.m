//
//  Artist.m
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import "Artist.h"
@implementation Artist
- (id)initWithArtistName:(NSString *)artistName
{
    self = [super init];
    if (self) {
        _name = artistName;
    }
    return self;
}
@end
