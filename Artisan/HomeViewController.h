//
//  ViewController.h
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    kResultsSectionArtistInformation,
    kResultsSectionArtistMixes,
    kResultsSectionCount
} ResultsSection;

@interface HomeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@end
