//
//  SearchView.m
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import "SearchView.h"
#import "ArtistInformationResultsHandler.h"
#import "QuartzCore/CoreAnimation.h"

@interface SearchView ()

@end

@implementation SearchView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.alpha = 0.6;
        self.backgroundColor = [UIColor whiteColor];
        
        self.searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.searchButton addTarget:self action:@selector(performSearchQuery) forControlEvents:UIControlEventTouchUpInside];
        [self.searchButton setBackgroundImage:[UIImage imageNamed:@"SearchIcon"] forState:UIControlStateNormal];
        [self.searchButton sizeToFit];
        self.searchButton.top = kPadding;
        self.searchButton.right = frame.size.width - kPadding;
        [self addSubview:self.searchButton];
        
        self.searchField = [[UITextField alloc] initWithFrame:CGRectMake(frame.origin.x + kPadding, frame.origin.y + kPadding, frame.size.width - self.searchButton.width - (kPadding * 3), frame.size.height - (kPadding * 2))];
        self.searchField.placeholder = [@"Search artists..." uppercaseString];
        self.searchField.delegate = self;
        self.searchField.autocorrectionType = UITextAutocorrectionTypeNo;
        self.searchField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        self.searchField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        self.searchField.returnKeyType = UIReturnKeySearch;
        self.searchField.clearsOnBeginEditing = YES;
        self.searchField.clearButtonMode = UITextFieldViewModeWhileEditing;
        self.searchField.font = [Artisan boldFontOfSize:20.0];
        [self addSubview:self.searchField];
    }
    return self;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSRange lowercaseCharRange;
    lowercaseCharRange = [string rangeOfCharacterFromSet:[NSCharacterSet lowercaseLetterCharacterSet]];
    
    if (lowercaseCharRange.location != NSNotFound) {
        textField.text = [textField.text stringByReplacingCharactersInRange:range
                                                                 withString:[string uppercaseString]];
        
        return NO;
    }
    
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField*)textField;
{
    if (textField == self.searchField){
        [self performSearchQuery];
    }
    return NO; // we do not want UITextField to insert line-breaks
}


- (void)performSearchQuery {
    if ([self.searchField isFirstResponder]) {
        [self.searchField resignFirstResponder];
        [ArtistInformationResultsHandler performArtistQuery:[[Artist alloc] initWithArtistName:self.searchField.text]];
        
        [SearchView pulse:self.searchButton toSize:0.8 withDuration:1.0];
    }
    else {
        [self.searchField becomeFirstResponder];
    }
}

+ (void)pulse:(UIView*)view toSize: (float) value withDuration:(float) duration
{
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    pulseAnimation.duration = duration;
    pulseAnimation.toValue = [NSNumber numberWithFloat:value];;
    pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pulseAnimation.autoreverses = YES;
    pulseAnimation.repeatCount = FLT_MAX;
    
    [view.layer addAnimation:pulseAnimation forKey:nil];
}

@end
