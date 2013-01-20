//
//  ArtistInformationResultsHandler.m
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import "ArtistInformationResultsHandler.h"
#import "AFJSONRequestOperation.h"
#import "Artist.h"
#import "Mix.h"
#import "NSString+HTML.h"

@implementation ArtistInformationResultsHandler

+ (void) performArtistQuery:(Artist*)artist {
    NSString *artistParameter = (__bridge NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)artist.name, NULL, (CFStringRef)@"!’\"();:@&=+$,/?%#[]% ", kCFStringEncodingISOLatin1);
    
    NSURLRequest *bioRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[[ARTIST_API_ENDPOINT stringByAppendingString:artistParameter] stringByAppendingFormat:@"&%@%@", API_KEY_PARAMETER, LAST_FM_API_KEY]]];
    AFJSONRequestOperation *bioOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:bioRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {

        // TODO: API Error Checking / Handling
        
        artist.biography = [[[[JSON objectForKey:@"artist"] objectForKey:@"bio"] objectForKey:@"summary"] stringByConvertingHTMLToPlainText];
    
        for (NSDictionary *image in [[JSON objectForKey:@"artist"] objectForKey:@"image"]) {
            if ([[image objectForKey:@"size"] isEqualToString:@"mega"]) {
                artist.imageURL = [NSURL URLWithString:[image objectForKey:@"#text"]];
            }
        }
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVED_ARTIST_INFORMATION
                                                            object:self
                                                          userInfo:[NSDictionary dictionaryWithObject:artist forKey:RECEIVED_ARTIST_INFORMATION]];
                            
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failure Because %@", [error userInfo]);
    }];
    
    [bioOperation start];
    
    NSURLRequest *mixRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:[[MIX_API_ENDPOINT stringByAppendingString:artistParameter] stringByAppendingFormat:@"&%@%@", API_KEY_PARAMETER, EIGHT_TRACKS_API_KEY]]];
    AFJSONRequestOperation *mixOperation = [AFJSONRequestOperation JSONRequestOperationWithRequest:mixRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        // TODO: API Error Checking / Handling
        
        NSMutableArray *mixes = [[NSMutableArray alloc] initWithCapacity:[[JSON objectForKey:@"mixes"] count]];
        
        for (NSDictionary *mixData in [JSON objectForKey:@"mixes"]) {
            Mix *mix = [[Mix alloc] initMixWithData:mixData];
            [mixes addObject:mix];
        }
        
        artist.mixes = mixes;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:RECEIVED_ARTIST_MIXES
                                                            object:self
                                                          userInfo:[NSDictionary dictionaryWithObject:artist forKey:RECEIVED_ARTIST_MIXES]];
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        NSLog(@"Request Failure Because %@", [error userInfo]);
    }];
    
    [mixOperation start];
}
@end
