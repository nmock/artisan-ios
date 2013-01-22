//
//  ArtisanHelpers.m
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import "Artisan.h"

@implementation Artisan
+ (CGFloat) calculateLabelHeightWithText:(NSString*)text andFont:(UIFont *)font thatFitsWidth:(CGFloat)width {
    CGSize labelSize = [text sizeWithFont:font
                        constrainedToSize:CGSizeMake(width, 10000)
                            lineBreakMode:NSLineBreakByWordWrapping];
    
    CGFloat labelHeight = labelSize.height;
    
    return labelHeight;
}

+ (UIFont*) defaultBodyFont {
    return [self fontOfSize:11.0];
}

+ (UIColor *) defaultColor {
    return [UIColor colorWithRed:17.0/255.0 green:44.0/255.0 blue:78.0/255.0 alpha:1.0];
}

+ (UIFont*) fontOfSize:(NSInteger)size {
    return [UIFont fontWithName:@"OpenSans-Light" size:size];
}

+ (UIFont*) boldFontOfSize:(NSInteger)size {
    return [UIFont fontWithName:@"OpenSans-Extrabold" size:size];
}

@end
