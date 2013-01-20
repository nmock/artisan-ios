//
//  ArtistInformationView.m
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import "ArtistInformationView.h"
#import "UIImageView+AFNetworking.h"

@implementation ArtistInformationView

static const CGFloat artistImageHeight = 140.0;

- (id)initWithArtist:(Artist*)artist
{
    self = [super init];
    if (self) {
        NSURLRequest *request = [NSURLRequest requestWithURL:artist.imageURL];
        
        UIView *artistImagePlaceholderContainer = [[UIView alloc] initWithFrame:CGRectMake(kPadding, kPadding, 320.0 - (kPadding * 2), artistImageHeight)];
        artistImagePlaceholderContainer.backgroundColor = [UIColor lightGrayColor];
        artistImagePlaceholderContainer.alpha = 0.60;
        artistImagePlaceholderContainer.clipsToBounds = YES;
        artistImagePlaceholderContainer.layer.borderColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:0.1].CGColor;
        artistImagePlaceholderContainer.layer.borderWidth = 1.0;
        artistImagePlaceholderContainer.layer.shadowColor = [UIColor blackColor].CGColor;
        artistImagePlaceholderContainer.layer.shadowOpacity = 0.1;
        artistImagePlaceholderContainer.layer.shadowOffset = CGSizeMake(0.0, -0.1f);
        [self addSubview:artistImagePlaceholderContainer];
        
        UIImageView *artistImagePlaceholder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ArtistImagePlaceholder"]];
        artistImagePlaceholder.center = CGPointMake(artistImagePlaceholderContainer.width / 2, artistImagePlaceholderContainer.height / 2);
        [artistImagePlaceholderContainer addSubview:artistImagePlaceholder];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.alpha = 0.0;
        [artistImagePlaceholderContainer addSubview:imageView];
        
        __weak UIImageView *receivedImageView = imageView;
        
        [imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            receivedImageView.image = image;
            
            [receivedImageView sizeToFit];
            receivedImageView.width = artistImagePlaceholderContainer.width;
            
            [UIView animateWithDuration:0.3 animations:^{
                artistImagePlaceholderContainer.alpha = 1.0;
                receivedImageView.alpha = 1.0;
            } completion:^(BOOL finished) {
                [artistImagePlaceholder removeFromSuperview]; // cleanup
            }];
        } failure:nil];
        
        UIView *artistBiographyContainer = [[UIView alloc] initWithFrame:CGRectMake(kPadding, artistImagePlaceholderContainer.bottom + kPadding, 320.0 - (kPadding * 2), 300.0)];
        artistBiographyContainer.backgroundColor = [UIColor lightGrayColor];
        artistBiographyContainer.alpha = 0.60;
        artistBiographyContainer.layer.borderColor = [UIColor colorWithRed:100.0/255.0 green:100.0/255.0 blue:100.0/255.0 alpha:0.1].CGColor;
        artistBiographyContainer.layer.borderWidth = 1.0;
        artistBiographyContainer.layer.shadowColor = [UIColor blackColor].CGColor;
        artistBiographyContainer.layer.shadowOpacity = 0.1;
        artistBiographyContainer.layer.shadowOffset = CGSizeMake(0.0, -0.1f);
        [self addSubview:artistBiographyContainer];
        
        UILabel *artistBiography = [[UILabel alloc] initWithFrame:artistBiographyContainer.frame];
        artistBiography.font = [Artisan defaultBodyFont];
        artistBiography.numberOfLines = 0;
        artistBiography.top = kPadding;
        artistBiography.width = artistBiographyContainer.width - (kPadding * 2);
        artistBiography.height = [Artisan calculateLabelHeightWithText:artist.biography andFont:artistBiography.font thatFitsWidth:artistBiography.width];
        artistBiography.text = artist.biography;
        artistBiography.backgroundColor = [UIColor clearColor];
        [artistBiographyContainer addSubview:artistBiography];
        
        artistBiographyContainer.height = artistBiography.height + (kPadding * 2);
        
        UILabel *artistName = [[UILabel alloc] init];
        artistName.text = [artist.name uppercaseString];
        artistName.backgroundColor = [UIColor clearColor];
        artistName.font = [Artisan boldFontOfSize:11.0];
        artistName.alpha = 0.9;
        [artistName sizeToFit];
        artistName.origin = CGPointMake(kPaddingSmall, kPaddingSmall);
        
        
        UIView *artistNameContainer = [[UIView alloc] initWithFrame:CGRectMake(artistImagePlaceholderContainer.right - artistName.width - (kPaddingSmall * 2) - 1, artistImagePlaceholderContainer.bottom - artistName.height - (kPaddingSmall * 2) - 1, artistName.width + (kPaddingSmall * 2), artistName.height + (kPaddingSmall * 2))];
        artistNameContainer.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
        [artistNameContainer addSubview:artistName];
        [self addSubview:artistNameContainer];
        
        self.frame = CGRectMake(0, 0, 320.0, ([artist.biography length] > 0) ? artistImageHeight + [Artisan calculateLabelHeightWithText:artist.biography andFont:[Artisan defaultBodyFont] thatFitsWidth:320.0 - (kPadding * 4)] + (kPadding * 5) : artistImageHeight + (kPadding * 2));
    }
    return self;
}

+ (CGFloat) cellHeightForArtist:(Artist*)artist {
    
    return ([artist.biography length] > 0) ? artistImageHeight + [Artisan calculateLabelHeightWithText:artist.biography andFont:[Artisan defaultBodyFont] thatFitsWidth:320.0 - (kPadding * 4)] + (kPadding * 5) : artistImageHeight + (kPadding * 2);
}

@end
