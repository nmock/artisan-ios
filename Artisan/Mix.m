//
//  Mix.m
//  Artisan
//
//  Created by Nathan Mock on 1/20/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import "Mix.h"

@implementation Mix
- (id)initMixWithData:(NSDictionary*)mixData
{
    self = [super init];
    if (self) {
        _name = [mixData objectForKey:@"name"];
        _coverImageURL = [NSURL URLWithString:[[mixData objectForKey:@"cover_urls"] objectForKey:@"sq500"]];
        _mixURL = [NSURL URLWithString:[@"http://m.8tracks.com/" stringByAppendingString:[mixData objectForKey:@"path"]]];
    }
    return self;
}
@end
