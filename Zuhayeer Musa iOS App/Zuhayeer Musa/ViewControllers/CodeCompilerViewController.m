//
//  CodeCompilerViewController.m
//  Zuhayeer Musa
//
//  Created by Zuhayeer Musa on 4/10/14.
//  Copyright (c) 2014 Zuhayeer Musa. All rights reserved.
//

#import "CodeCompilerViewController.h"
#import "jsonParser.h"

@interface CodeCompilerViewController () {
    jsonParser *parser;
}
@property (weak, nonatomic) IBOutlet UILabel *outputLabel;
@property (weak, nonatomic) IBOutlet UILabel *outputView;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation CodeCompilerViewController
@synthesize webView;

NSString *languageSelected = nil;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [self.outputView setHidden:true];
    [self.outputLabel setHidden:true];
    
    languageSelected = @"Java";
    
    parser = [[jsonParser alloc]init];
    
    // Init URL from directory
    NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"]];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.delegate = self;
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void) webViewDidFinishLoad:(UIWebView *)_webView
{
//    NSString *codeString = @"System.out.println(\"Hello World\");
    NSString *codeString = @"public class Code { public static void main (String [] args) { System.out.println(\"Hello\"); } }";
    codeString = [codeString stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    codeString = [codeString stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
    [_webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"initCode('%@', '%@')", @"java", codeString]];
}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if ([[[request URL] absoluteString] hasPrefix:@"ios:"]) {
        
        // Call the given selector
        [self performSelector:@selector(webToNativeCall)];
        // Cancel the location change
        return NO;
    }
    return YES;
    
}

- (void)webToNativeCall
{
    // Compile button calls here
    [self.outputLabel setHidden:false];
    self.outputLabel.text = @"Please wait...";
    NSString *returnvalue =  [self.webView stringByEvaluatingJavaScriptFromString:@"getModifiedCode()"];
    NSLog(@"%@", returnvalue); // the modified code returned;
    [parser returnJsonwithParam:@{@"code": returnvalue, @"language": languageSelected} andEndpointString:@"https://zuhayeer-wwdc.herokuapp.com/compile" WithHandler:^(NSArray *result) {
        NSLog(@"%@", result[0]);
        self.outputLabel.text = @"Output";
        self.outputView.text = result[0];
        [self.outputView setHidden:false];
        [self.outputLabel setHidden:false];
    }];
    
}

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
- (IBAction)segmentedControlChanged:(id)sender {
    [self.outputView setHidden:true];
    [self.outputLabel setHidden:true];
    if ([sender selectedSegmentIndex] == 0) {
        languageSelected = @"Java";
        NSString *codeString = @"public class Code { public static void main (String [] args) { System.out.println(\"Hello\"); } }";
        codeString = [codeString stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        codeString = [codeString stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"updateTheEditor('%@', '%@')", @"java", codeString]];

    } else if ([sender selectedSegmentIndex] == 1) {
        languageSelected = @"Python";
        NSString *codeString = @"print \"Hello\"";
        codeString = [codeString stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        codeString = [codeString stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"updateTheEditor('%@', '%@')", @"python", codeString]];
    } else if ([sender selectedSegmentIndex] == 2) {
        languageSelected = @"Javascript";
        NSString *codeString = @"console.log(\"Hello World\");";
        codeString = [codeString stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
        codeString = [codeString stringByReplacingOccurrencesOfString:@"'" withString:@"\\'"];
        [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"updateTheEditor('%@', '%@')", @"javascript", codeString]];
    }
}

@end
