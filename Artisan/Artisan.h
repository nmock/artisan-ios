//
//  ArtisanHelpers.h
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Artisan : NSObject
+ (CGFloat) calculateLabelHeightWithText:(NSString*)text andFont:(UIFont *)font thatFitsWidth:(CGFloat)width;
+ (UIFont*) defaultBodyFont;
+ (UIColor *) defaultColor;
+ (UIFont*) fontOfSize:(NSInteger)size;
+ (UIFont*) boldFontOfSize:(NSInteger)size;
@end
