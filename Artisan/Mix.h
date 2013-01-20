//
//  Mix.h
//  Artisan
//
//  Created by Nathan Mock on 1/20/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mix : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSURL *coverImageURL;
@property (nonatomic, strong, readonly) NSURL *mixURL;

- (id)initMixWithData:(NSDictionary*)mixData;
@end
