//
//  MixView.h
//  Artisan
//
//  Created by Nathan Mock on 1/20/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Mix.h"

static const CGFloat mixDimensions = 192.0;

@interface MixView : UIView
- (id)initWithMix:(Mix*)mix;
- (void)playMix;
@end
