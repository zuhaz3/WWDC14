//
//  MasterViewController.m
//  Zuhayeer Musa
//
//  Created by Zuhayeer Musa on 4/4/14.
//  Copyright (c) 2014 Zuhayeer Musa. All rights reserved.
//

#import "MasterViewController.h"
#import "BrowseCodeViewController.h"


#define kItemKeyTitle       @"title"
#define kItemKeyDescription @"description"
#define kItemKeyClassPrefix @"prefix"
#define kItemKeyImage       @"imgUrl"


@interface MasterViewController ()
@property (nonatomic, strong) NSArray *
items;
@property (nonatomic, strong) NSString *currentClassName;
@end


@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.items = @[
                   
                   // Background
                   @{kItemKeyTitle: @"Background",
                     kItemKeyDescription: @"A little bit about who I am and what I do.",
                     kItemKeyClassPrefix: @"MyBackground",
                     kItemKeyImage: @"goldengate.png",
                     },
                   
                   // Projects
                   @{kItemKeyTitle: @"Projects",
                     kItemKeyDescription: @"Some of my latest works and crafts built from the ground up",
                     kItemKeyClassPrefix: @"ProjectsTable",
                     kItemKeyImage: @"sourcecode.png",
                     },
                   
                   // Dynamic Behaviors
                   @{kItemKeyTitle: @"Code Compiler",
                     kItemKeyDescription: @"Code and compile in your selection of Java, Python, or JavaScript",
                     kItemKeyClassPrefix: @"CodeCompiler",
                     kItemKeyImage: @"servers.png",
                     },
                   
                   // Resume
                   @{kItemKeyTitle: @"Résumé",
                     kItemKeyDescription: @"If you like my work, let's get in touch.",
                     kItemKeyClassPrefix: @"CronResume",
                     kItemKeyImage: @"hackathon.png",
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
//    cell.textLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
//    cell.textLabel.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
//    cell.textLabel.layer.shadowOpacity = 2.0f;
//    cell.textLabel.layer.shadowRadius = 3.0f;
    UIFont *myFont = [ UIFont fontWithName: @"HelveticaNeue-Light" size: 24.0 ];
    cell.textLabel.font  = myFont;
    
    // DetailTextLabel
    cell.detailTextLabel.text = info[kItemKeyDescription];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    UIFont *myFontDetail = [ UIFont fontWithName: @"HelveticaNeue-Thin" size:14.0 ];
    cell.detailTextLabel.font = myFontDetail;
//    cell.detailTextLabel.layer.shadowColor = [[UIColor whiteColor] CGColor];
//    cell.detailTextLabel.layer.shadowOffset = CGSizeMake(2.0f, 2.0f);
//    cell.detailTextLabel.layer.shadowOpacity = 2.0f;
//    cell.detailTextLabel.layer.shadowRadius = 3.0f;
    
    
    NSString *imgName = [NSString stringWithFormat:@"%@", info[kItemKeyImage]];
    UIImage *imageView = [UIImage imageNamed:imgName];
    cell.backgroundView = [[UIImageView alloc] initWithImage:imageView];
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
            
//            UIBarButtonItem *barBtnItem = [[UIBarButtonItem alloc] initWithTitle:@"View Code"
//                                                                           style:UIBarButtonItemStylePlain
//                                                                          target:self
//                                                                          action:@selector(viewCodeButtonTapped:)];
//            [(UIViewController *)instance navigationItem].rightBarButtonItem = barBtnItem;
            [(UIViewController *)instance setTitle:item[kItemKeyTitle]];
            [self.navigationController pushViewController:(UIViewController *)instance
                                                 animated:YES];
        }
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


// =============================================================================
#pragma mark - Actions

- (void)viewCodeButtonTapped:(id)sender {

    NSString *urlStr = [NSString stringWithFormat:@"http://github.com/zuhaz3"];
    NSLog(@"url:%@", urlStr);
    
    BrowseCodeViewController *codeCtr = [[BrowseCodeViewController alloc] init];

    [codeCtr setTitle:self.currentClassName];
    [codeCtr setUrlString:urlStr];

    [self.navigationController pushViewController:codeCtr
                                         animated:YES];
}

@end
