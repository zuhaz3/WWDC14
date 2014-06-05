//
//  MyBackgroundViewController.m
//  Zuhayeer Musa
//
//  Created by Zuhayeer Musa on 4/5/14.
//  Copyright (c) 2014 Zuhayeer Musa. All rights reserved.
//

//#import "SpeechSynthesisViewController.h"
#import "MyBackgroundViewController.h"
#import <MapKit/MapKit.h>
#import <AVFoundation/AVFoundation.h>
//#import "SVProgressHUD.h"


@interface MyBackgroundViewController ()
<UINavigationControllerDelegate>
//@property (nonatomic, weak) IBOutlet MKMapView *mapView;
//@property (nonatomic, weak) IBOutlet UIImageView *imageView;
//@property (weak, nonatomic) IBOutlet UITextView *aboutText;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UITextView *aboutText;
@property (weak, nonatomic) IBOutlet UITextView *myTextView;
@property (nonatomic, strong) AVSpeechSynthesizer *synthesizer;
@end


@implementation MyBackgroundViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // map setup
    self.mapView.centerCoordinate = CLLocationCoordinate2DMake(37.3575, -122.0319);
    self.mapView.camera.altitude = 5000;
    self.mapView.camera.pitch = 70;
    self.mapView.showsBuildings = YES;
    
    self.synthesizer = [[AVSpeechSynthesizer alloc] init];
    
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:self.aboutText.text];
    utterance.rate = 0.3f;
    
    self.myTextView.textColor = [UIColor whiteColor];
    //[self.synthesizer speakUtterance:utterance];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


// =============================================================================
#pragma mark - IBAction

//- (IBAction)createSnapshot {
//    
//    [SVProgressHUD showWithStatus:@"Creating a screenshot..."
//                         maskType:SVProgressHUDMaskTypeGradient];
//    
//    MKMapSnapshotOptions *options = [[MKMapSnapshotOptions alloc] init];
//    options.size = CGSizeMake(512, 512);
//    options.scale = [[UIScreen mainScreen] scale];
//    options.camera = self.mapView.camera;
//    options.mapType = MKMapTypeStandard;
//    
//    MKMapSnapshotter *snapshotter = [[MKMapSnapshotter alloc] initWithOptions:options];
//    
//    [snapshotter startWithCompletionHandler:^(MKMapSnapshot *snapshot, NSError *e) {
//        if (e) {
//            NSLog(@"error:%@", e);
//        }
//        else {
//            
//            [SVProgressHUD showSuccessWithStatus:@"done!"];
//            
//        }
//    }];
//}

@end
