//
//  ProjectsTableViewController.m
//  Zuhayeer Musa
//
//  Created by Zuhayeer Musa on 4/7/14.
//  Copyright (c) 2014 Zuhayeer Musa. All rights reserved.
//

#import "ProjectsTableViewController.h"
#import "BrowseCodeViewController.h"


#define kItemKeyTitle       @"title"
#define kItemKeyDescription @"description"
#define kItemKeyClassPrefix @"prefix"
#define kItemKeyImage       @"imgUrl"

#define UIColorFromRGBWithAlpha(rgbValue,a) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:a]


@interface ProjectsTableViewController ()
@property (nonatomic, strong) NSArray *
items;
@property (nonatomic, strong) NSString *currentClassName;
@end


@implementation ProjectsTableViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[
                   
                   // Fess
                   @{kItemKeyTitle: @"Fess",
                     kItemKeyDescription: @"A simple anonymous application for high schoolers. Worked on the server side and frontend development.",
                     kItemKeyClassPrefix: @"Fess",
                     kItemKeyImage: @"goldengate.png",
                     },
                   
                   // YTFind
                   @{kItemKeyTitle: @"YTFind",
                     kItemKeyDescription: @"Search for dialogue in a YouTube video and navigate right to that point (API and Extension)",
                     kItemKeyClassPrefix: @"YTFind",
                     kItemKeyImage: @"goldengate.png",
                     },
                   
                   // Sync
                   @{kItemKeyTitle: @"Sync",
                     kItemKeyDescription: @"Synchronizes all your notifications across all platforms including iOS, Android, Windows, and the web.",
                     kItemKeyClassPrefix: @"Sync",
                     kItemKeyImage: @"sourcecode.png",
                     },
                   
                   // Spruce
                   @{kItemKeyTitle: @"Spruce",
                     kItemKeyDescription: @"Educational tool which allows readers to highlight words they don't know and find their definition, picture, and pronunciation which can all be saved to Evernote.",
                     kItemKeyClassPrefix: @"Spruce",
                     kItemKeyImage: @"sourcecode.png",
                     },
                   ];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    // Needed after custome transition
    self.navigationController.delegate = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


// =============================================================================
#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.textLabel.textColor = [UIColor colorWithRed:51./255.
                                                   green:153./255.
                                                    blue:204./255.
                                                   alpha:1.0];
        cell.detailTextLabel.numberOfLines = 0;
    }
    
    
	NSDictionary *info = [self.items objectAtIndex:indexPath.row];
    
    // TextLabel
    cell.textLabel.text = info[kItemKeyTitle];
    cell.textLabel.textColor = [UIColor whiteColor];
    UIFont *myFont = [ UIFont fontWithName: @"HelveticaNeue-Light" size: 24.0 ];
    cell.textLabel.font  = myFont;
    
    // DetailTextLabel
    cell.detailTextLabel.text = info[kItemKeyDescription];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    UIFont *myFontDetail = [ UIFont fontWithName: @"HelveticaNeue-Thin" size:14.0 ];
    cell.detailTextLabel.font = myFontDetail;
    
    // Image Name
    UIView *myView = [[UIView alloc] init];
    if (indexPath.row == 0)
        myView.backgroundColor = UIColorFromRGBWithAlpha(0x6fcefb, 1);
    if (indexPath.row == 1)
        myView.backgroundColor = UIColorFromRGBWithAlpha(0xe74040, 1);
    if (indexPath.row == 2)
        myView.backgroundColor = UIColorFromRGBWithAlpha(0x017fff, 1);
    if (indexPath.row == 3)
        myView.backgroundColor = UIColorFromRGBWithAlpha(0xff9000, 1);
    cell.backgroundView = myView;
    return cell;
}


// =============================================================================
#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 126.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *item = self.items[indexPath.row];
    NSString *className = [item[kItemKeyClassPrefix] stringByAppendingString:@"ViewController"];
    
    if (NSClassFromString(className)) {
        
        Class aClass = NSClassFromString(className);
        id instance = [[aClass alloc] init];
        
        if ([instance isKindOfClass:[UIViewController class]]) {
            
            self.currentClassName = className;
            if ([item[kItemKeyClassPrefix] isEqualToString:@"Fess"]) {
                       UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"App Store"
                                                                                      style:UIBarButtonItemStylePlain
                                                                                     target:self
                                                                                      action:@selector(appStoreButtonTapped:)];
                        [(UIViewController *)instance navigationItem].rightBarButtonItem = barBtnItem;
            } else if ([item[kItemKeyClassPrefix] isEqualToString:@"Spruce"]) {
                UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"More..."
                                                                               style:UIBarButtonItemStylePlain
                                                                              target:self
                                                                              action:@selector(moreButtonTapped:)];
                [(UIViewController *)instance navigationItem].rightBarButtonItem = barBtnItem;
            }
            [(UIViewController *)instance setTitle:item[kItemKeyTitle]];
            [self.navigationController pushViewController:(UIViewController *)instance
                                                 animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// =============================================================================
#pragma mark - Actions

- (void)appStoreButtonTapped:(id)sender {
    
    NSString *iTunesLink = @"https://itunes.apple.com/us/app/fessapp/id836931002?ls=1&mt=8";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];

}

- (void)moreButtonTapped:(id)sender {
    
    NSString *url = @"http://tcrn.ch/1etXWaN";
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

@end
