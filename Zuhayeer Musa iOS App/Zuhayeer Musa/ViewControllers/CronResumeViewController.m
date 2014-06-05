//
//  CronResumeViewController.m
//  iOS7Sampler
//
//  Created by Zuhayeer Musa on 4/4/14.
//  Copyright (c) 2014 Zuhayeer Musa. All rights reserved.
//

#import "CronResumeViewController.h"
#import "jsonParser.h"

@interface CronResumeViewController ()
<UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>{
    jsonParser *parser;
}
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UITextField *textView;
@property (weak, nonatomic) IBOutlet UIButton *myButton;
//@property (nonatomic, strong) NSArray *items;
@property (weak, nonatomic) IBOutlet UILabel *myCounter;
//@property (weak, nonatomic) IBOutlet UIPickerView *myPicker;
@property (nonatomic, strong) NSString *selectedPickerValue;
@end

@implementation CronResumeViewController
@synthesize webView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    
//    [self.myPicker selectRow:2 inComponent:0 animated:YES];
//    self.selectedPickerValue = self.items[2];
//    [self.myPicker reloadComponent:0];
}

- (void)viewDidLoad
{
    NSURL *url = [NSURL URLWithString:@"http://attosoft.com/zuhayeer-musa.pdf"];
    [webView loadRequest:[NSURLRequest requestWithURL:url]];
    webView.delegate = self;
    [super viewDidLoad];
    parser = [[jsonParser alloc]init];
    [self.myCounter setHidden:true];

    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 0;
}


// =============================================================================
#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return @"0 minute";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//    self.selectedPickerValue = self.items[row];
}


// Also remember to add a Parse Push Notification when the email is sent - talk to Ash

- (IBAction)sendEmail {
    
    NSString *textValue = [NSString stringWithFormat:@"%@", self.textView.text];

    
    NSString *emailid = textValue;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest =[NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL myStringMatchesRegEx=[emailTest evaluateWithObject:emailid];
    
    if (myStringMatchesRegEx) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Look out for the email"
                                                       delegate:nil
                                              cancelButtonTitle:@"Nice"
                                              otherButtonTitles:nil];
        [alert show];
        self.textView.text = @"";
        [self.textView setHidden:true];
        //            [self.myPicker setHidden:true];
        [self.myButton setHidden:true];
        [self.view endEditing:true];
        self.myCounter.text = [NSString stringWithFormat:@"Check your email!"];
        self.myCounter.textColor = [UIColor blackColor];
        [self.myCounter setHidden:false];
        [parser returnJsonwithParam:@{@"email": textValue, @"time": @"0 minute"} andEndpointString:@"https://zuhayeer-wwdc.herokuapp.com/sendResumeEmail" WithHandler:^(NSArray *result) {
        }];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Invalid Email"
                                                        message:@"Please enter a valid email for the resume to be sent."
                                                       delegate:nil
                                              cancelButtonTitle:@"Okay, fine"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


@end
