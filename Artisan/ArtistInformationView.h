//
//  ArtistInformationView.h
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artist.h"

@interface ArtistInformationView : UIView
- (id)initWithArtist:(Artist*)artist;
+ (CGFloat) cellHeightForArtist:(Artist*)artist;
@end
