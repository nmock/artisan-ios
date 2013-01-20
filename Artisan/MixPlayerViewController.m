//
//  MixPlayerViewController.m
//  Artisan
//
//  Created by Nathan Mock on 1/20/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import "MixPlayerViewController.h"
#import <AVFoundation/AVFoundation.h>


@implementation MixPlayerViewController

- (id)initWithMixURL:(NSURL *)mixURL
{
    self = [super init];
    if (self) {
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        BOOL ok;
        NSError *setCategoryError = nil;
        ok = [audioSession setCategory:AVAudioSessionCategoryPlayback
                                 error:&setCategoryError];
        if (!ok) {
            NSLog(@"%s setCategoryError=%@", __PRETTY_FUNCTION__, setCategoryError);
        }
        
        UIWebView *webView = [[UIWebView alloc] init];
        webView.frame = self.view.bounds;
        webView.height -= 60;
        webView.scalesPageToFit = YES;
        [webView loadRequest:[NSURLRequest requestWithURL:mixURL]];
        [self.view addSubview:webView];
        
        UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [closeButton setImage:[UIImage imageNamed:@"CloseButtonIcon"] forState:UIControlStateNormal];
        [closeButton addTarget:self action:@selector(dismissModalViewControllerAnimated:) forControlEvents:UIControlEventTouchUpInside];
        [closeButton sizeToFit];
        
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismissModalViewControllerAnimated:)];
        
        UILabel *mixTitle = [[UILabel alloc] init];
        mixTitle.text = [@"Mix" uppercaseString];
        mixTitle.textColor = [UIColor colorWithWhite:1.0 alpha:0.9];
        mixTitle.backgroundColor = [UIColor clearColor];
        mixTitle.font = [Artisan boldFontOfSize:13.0];
        mixTitle.alpha = 0.9;
        [mixTitle sizeToFit];
        
        self.navigationItem.titleView = mixTitle;
    }
    return self;
}

@end
