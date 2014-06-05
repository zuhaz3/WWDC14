//
//  FessViewController.m
//  Zuhayeer Musa
//
//  Created by Zuhayeer Musa on 4/7/14.
//  Copyright (c) 2014 Shuichi Tsutsumi. All rights reserved.
//

#import "FessViewController.h"

@interface FessViewController()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation FessViewController
@synthesize webView;

//-(IBAction)goBack:(id)sender {
//    if ([webView canGoBack]) {
//        [webView goBack];
//    }
//}
//
//-(IBAction)goForward:(id)sender {
//    if ([webView canGoForward]) {
//        [webView goForward];
//    }
//}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    // NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"]];
    NSURL *url = [NSURL URLWithString:@"http://fessapp.com"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.delegate = self;
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

//- (void) webViewDidFinishLoad:(UIWebView *)_webView
//{
//    NSString *codeString = @"var json = \"true\";";
//    codeString = [codeString stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
//    codeString = [codeString stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
//    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initCode('%@', '%@')", @"javascript", codeString]];
//}
//
//- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
//    if ([[[request URL] absoluteString] hasPrefix:@"ios:"]) {
//        
//        // Call the given selector
//        [self performSelector:@selector(webToNativeCall)];
//        // Cancel the location change
//        return NO;
//    }
//    return YES;
//    
//}
//
//- (void)webToNativeCall
//{
//    // Compile button calls here
//    NSString *returnvalue =  [self.webView stringByEvaluatingJavaScriptFromString:@"getModifiedCode()"];
//    NSLog(@"%@", returnvalue); // the modified code returned;
//}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
