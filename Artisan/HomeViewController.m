//
//  ViewController.m
//  Artisan
//
//  Created by Nathan Mock on 1/19/13.
//  Copyright (c) 2013 Nathan Mock. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchView.h"
#import "ArtistInformationResultsHandler.h"
#import "ArtistInformationView.h"
#import "MixScrollView.h"
#import "UIView+ViewHelpers.h"

@interface HomeViewController ()
@property (nonatomic, strong) SearchView *searchView;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) Artist *artist;

@property (nonatomic, strong) UIImageView *backgroundLogo;
@end

BOOL receivedArtistInformationResults = FALSE;
BOOL receivedArtistMixResults = FALSE;
static const CGFloat artistImageHeight = 140.0;

@implementation HomeViewController
- (id)init
{
    self = [super init];
    if (self) {
        [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"cardboard_flat"]]];
        
        self.searchView = [[SearchView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, [UIImage imageNamed:@"SearchIcon"].size.height + (kPadding * 2))];
        [self.view addSubview:self.searchView];
        
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.searchView.bottom, self.view.width, self.view.height - self.searchView.height)];
        self.tableView.dataSource = self;
        self.tableView.delegate = self;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableView.backgroundColor = [UIColor clearColor];
        self.tableView.showsVerticalScrollIndicator = NO;
        
        [self.view addSubview:self.tableView];
        
        self.backgroundLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BackgroundIcon"]];
        self.backgroundLogo.center = self.view.center;
        self.backgroundLogo.top -= self.searchView.height;
        [self.view addSubview:self.backgroundLogo];
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedArtistInformation:)
                                                 name:RECEIVED_ARTIST_INFORMATION
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receivedMixInformation:)
                                                 name:RECEIVED_ARTIST_MIXES
                                               object:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard Dismisser 
- (void)endEditing {
    [self.searchView endEditing:YES];

    if (self.artist) {
        self.searchView.searchField.text = self.artist.name;
    }
}

#pragma mark - Notification Handlers
- (void)receivedArtistInformation:(NSNotification *) notification {
    [UIApplication cancelPreviousPerformRequestsWithTarget:self selector:@selector(reallyReloadArtistInformation:) object:nil];
    [self performSelector:@selector(reallyReloadArtistInformation:) withObject:notification afterDelay:0.3]; // Try to avoid double notifications
}

- (void)receivedMixInformation:(NSNotification *) notification {
    [UIApplication cancelPreviousPerformRequestsWithTarget:self selector:@selector(reallyReloadMixInformation::) object:nil];
    [self performSelector:@selector(reallyReloadMixInformation:) withObject:notification afterDelay:0.3]; // Try to avoid double notifications
}

- (void) reallyReloadArtistInformation:(NSNotification *)notification {
    self.backgroundLogo.alpha = 0.0;
    
    [self.searchView.searchButton.layer removeAllAnimations];
    self.artist = [[notification userInfo] objectForKey:notification.name];
    receivedArtistInformationResults = TRUE;
    
    [self.tableView beginUpdates];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kResultsSectionArtistInformation] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kResultsSectionArtistMixes] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

- (void) reallyReloadMixInformation:(NSNotification *)notification {
    self.backgroundLogo.alpha = 0.0;
    
    [self.searchView.searchButton.layer removeAllAnimations];
    self.artist = [[notification userInfo] objectForKey:notification.name];
    receivedArtistMixResults = TRUE;
    
    [self.tableView beginUpdates];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kResultsSectionArtistInformation] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:kResultsSectionArtistMixes] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView endUpdates];
    
    [self.tableView setContentOffset:CGPointMake(0, 0) animated:YES];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return kResultsSectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // kResultsSectionArtistInformation
    if (section == kResultsSectionArtistInformation) {
        return receivedArtistInformationResults && (([self.artist.biography length] > 0) || self.artist.imageURL) ? 1 : 0;
    }
    
    // kResultsSectionArtistInformation
    else if (section == kResultsSectionArtistMixes) {
        return (receivedArtistMixResults && ([self.artist.mixes count] > 0)) ? 1 : 0;
    }

    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if ([self tableView:self.tableView numberOfRowsInSection:section] == 0) {
        return 0;
    }
    
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 30)];
    sectionView.backgroundColor = [Artisan defaultColor];
    
    UIImageView *mixLogo;
    UILabel *artistInformationLabel;
    
    // Configure section header
    switch (section) {
        case kResultsSectionArtistInformation:
            artistInformationLabel = [[UILabel alloc] init];
            artistInformationLabel.textColor = [UIColor colorWithWhite:0.96 alpha:1.0];
            artistInformationLabel.text = [@"Artist Information" uppercaseString];
            artistInformationLabel.backgroundColor = [UIColor clearColor];
            artistInformationLabel.font = [Artisan boldFontOfSize:12.0];
            [artistInformationLabel sizeToFit];
            artistInformationLabel.center = CGPointMake(sectionView.width / 2.0, sectionView.height / 2.0);
            [sectionView addSubview:artistInformationLabel];
            break;
        
        case kResultsSectionArtistMixes:
            mixLogo = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"8TracksLogo"]];
            mixLogo.center = CGPointMake(sectionView.width / 2.0, sectionView.height / 2.0);
            [sectionView addSubview:mixLogo];
            break;
            
        default:
            break;
    };
    
    return sectionView;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // DEVELOPER NOTE: Ideally, we would utilize cell re-use methods, however, for the sake of
    //                 brevity we are recreating views with each query. There is a performance hit
    //                 when we fail to use re-use methods, but because we are unconventionally utilizing
    //                 table view cells to display a single cell type, defining a re-usable cell would incur
    //                 an unperceivable performance benefit.
    
    if (indexPath.section == kResultsSectionArtistInformation) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        ArtistInformationView *artistInformationView = [[ArtistInformationView alloc] initWithArtist:self.artist];
        [cell.contentView addSubview:artistInformationView];

        return cell;
    }
    else if (indexPath.section == kResultsSectionArtistMixes) {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        MixScrollView *mixScrollView = [[MixScrollView alloc] initWithMixes:self.artist.mixes];
        [cell.contentView addSubview:mixScrollView];
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case kResultsSectionArtistInformation:
            return [ArtistInformationView cellHeightForArtist:self.artist];
            break;
            
        case kResultsSectionArtistMixes:
            return mixDimensions + (kPadding * 2);
            break;
            
        default:
            return 0;
            break;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self endEditing];
}

@end
