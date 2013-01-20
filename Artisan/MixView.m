//
//  MixView.m
//  Artisan
//
//  Created by Nathan Mock on 1/20/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import "MixView.h"
#import "UIImageView+AFNetworking.h"
#import "MixPlayerViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"

@interface MixView()
@property (nonatomic, strong) NSURL *mixURL;
@end

@implementation MixView

- (id)initWithMix:(Mix*)mix
{
    self = [super init];
    if (self) {
        self.mixURL = mix.mixURL;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:mix.coverImageURL];
        
        UIView *mixImagePlaceholderContainer = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 192.0, 192.0)];
        mixImagePlaceholderContainer.backgroundColor = [UIColor lightGrayColor];
        mixImagePlaceholderContainer.alpha = 0.60;
        mixImagePlaceholderContainer.clipsToBounds = YES;
        [self addSubview:mixImagePlaceholderContainer];
        
        UIImageView *mixImagePlaceholder = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MixPlaceholderIcon"]];
        mixImagePlaceholder.center = CGPointMake(mixImagePlaceholderContainer.width / 2, mixImagePlaceholderContainer.height / 2);
        [mixImagePlaceholderContainer addSubview:mixImagePlaceholder];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.alpha = 0.0;
        [mixImagePlaceholderContainer addSubview:imageView];
        
        __weak UIImageView *receivedImageView = imageView;
        
        [imageView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
            receivedImageView.image = image;
            receivedImageView.frame = mixImagePlaceholderContainer.frame;
            
            [UIView animateWithDuration:0.3 animations:^{
                mixImagePlaceholderContainer.alpha = 1.0;
                receivedImageView.alpha = 1.0;
            } completion:^(BOOL finished) {
                [mixImagePlaceholder removeFromSuperview]; // cleanup
            }];
        } failure:nil];
        
        UILabel *mixName = [[UILabel alloc] init];
        mixName.text = [mix.name uppercaseString];
        mixName.backgroundColor = [UIColor clearColor];
        mixName.font = [Artisan boldFontOfSize:11.0];
        mixName.alpha = 0.9;
        [mixName sizeToFit];
        mixName.width = mixDimensions - (kPaddingSmall * 2);
        mixName.origin = CGPointMake(kPaddingSmall, kPaddingSmall);
    
        UIView *mixNameBackground = [[UIView alloc] initWithFrame:CGRectMake(0, mixImagePlaceholderContainer.bottom - mixName.height - (kPaddingSmall * 2) - kPaddingSmall, mixDimensions, mixName.height + (kPaddingSmall * 2))];
        mixNameBackground.backgroundColor = [UIColor colorWithWhite:0.9 alpha:0.8];
        [mixNameBackground addSubview:mixName];
        [self addSubview:mixNameBackground];
    }
    return self;
}

- (void)playMix {
    MixPlayerViewController *mixPlayerViewController = [[MixPlayerViewController alloc] initWithMixURL:self.mixURL];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:mixPlayerViewController];
    HomeViewController *homeViewController = [AppDelegate sharedAppDelegate].viewController;
    [homeViewController presentViewController:navigationController animated:YES completion:nil];
    
//    [[UIApplication sharedApplication] openURL:self.mixURL];
}
@end
