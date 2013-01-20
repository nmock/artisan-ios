//
//  ArtistInformationResultsHandler.h
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Artist.h"

#error  Please enter your API Keys and remove this line.

// http://www.last.fm/api/account/create
// http://8tracks.com/developers/new

#define LAST_FM_API_KEY @"XXXXXXXXXXXXXXXXXX"
#define EIGHT_TRACKS_API_KEY @"XXXXXXXXXXXXXXXXXX"

// DEVELOPER NOTE: Ideally, we would create an API client model abstraction, but for the
//                 sake of brevity we are hardcoding API endpoints.

// Last.FM Constants
#define ARTIST_API_ENDPOINT @"http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&format=json&artist="
#define RECEIVED_ARTIST_INFORMATION @"notify.receivedArtistInformation"

// 8Tracks Constants
#define MIX_API_ENDPOINT @"http://8tracks.com/mixes.json?api_version=2&q="
#define RECEIVED_ARTIST_MIXES @"notify.receivedArtistMixes"

// Other Constants
#define API_KEY_PARAMETER @"api_key="

@interface ArtistInformationResultsHandler : NSObject

+ (void) performArtistQuery:(Artist*)artist;

@end
