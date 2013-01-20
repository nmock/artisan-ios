//
//  MixScrollView.m
//  Artisan
//
//  Created by Nathan Mock on 1/20/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import "MixScrollView.h"

@interface MixScrollView ()
@property (nonatomic, strong) NSMutableArray *mixViews;
@end

@implementation MixScrollView

- (id)initWithMixes:(NSArray *)mixes
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, 320.0, mixDimensions + (kPadding * 2));
        self.contentSize = CGSizeMake(((mixDimensions + kPadding) * [mixes count]) + kPadding, self.height);
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
//        self.userInteractionEnabled = YES;
//        self.exclusiveTouch = NO;
//        self.canCancelContentTouches = YES;
//        self.delaysContentTouches = YES;
        
        self.mixViews = [[NSMutableArray alloc] initWithCapacity:[mixes count]];
        
        for (int i = 0; i < [mixes count]; i++) {
            MixView *mixView = [[MixView alloc] initWithMix:[mixes objectAtIndex:i]];
            mixView.origin = CGPointMake((mixDimensions * i) + (kPadding * (i + 1)), kPadding);
            [self addSubview:mixView];
            
            [self.mixViews addObject:mixView];
        }
        
        UITapGestureRecognizer *mixTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
        mixTapGesture.numberOfTapsRequired = 1;
        [self addGestureRecognizer:mixTapGesture];
    }
    return self;
}

- (void)handleTap:(UITapGestureRecognizer *)tap {
    CGPoint mPoint = [tap locationInView:tap.view];
    
    [((MixView *)[self.mixViews objectAtIndex:(int)(mPoint.x / (mixDimensions + kPadding))]) playMix];
}

@end
