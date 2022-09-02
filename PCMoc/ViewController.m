//
//  ViewController.m
//  PCMoc
//
//  Created by Feng on 8/23/22.
//

#import "ViewController.h"
#import <SafariServices/SafariServices.h>

@interface ViewController () <SFSafariViewControllerDelegate>

@end

@implementation ViewController

// This works
- (void) openInSafari{
    NSURL *adURL = [NSURL URLWithString:@"https://en.wikipedia.org/wiki/safari"];
    UIEventAttribution *eventAttribution = [[UIEventAttribution alloc]
                                            initWithSourceIdentifier:231
                                            destinationURL:adURL
                                            sourceDescription:@"test for app-to-safari PCM"
                                            purchaser:@"test"];
    
    // Scene Delegate
    UISceneOpenExternalURLOptions *sceneOpenURLOptions = [[UISceneOpenExternalURLOptions alloc] init];
    sceneOpenURLOptions.eventAttribution = eventAttribution;
    [self.view.window.windowScene openURL:adURL
                                    options:sceneOpenURLOptions
                        completionHandler:^(BOOL success) {
        if (success == NO) {
            // Handle error
        }
    }];
}


// This does not work
- (void) openInSVC{
    NSURL *adURL = [NSURL URLWithString:@"https://en.wikipedia.org/wiki/apple"];
    UIEventAttribution *eventAttribution = [[UIEventAttribution alloc]
                                            initWithSourceIdentifier:231
                                            destinationURL:adURL
                                            sourceDescription:@"test for SVC PCM"
                                            purchaser:@"test"];

    
    SFSafariViewControllerConfiguration *config = [[SFSafariViewControllerConfiguration alloc] init];
    config.eventAttribution = eventAttribution;
    config.entersReaderIfAvailable = YES;
    
    SFSafariViewController *svc = [[SFSafariViewController alloc] initWithURL:adURL configuration:config];
    svc.delegate = self;
    [self presentViewController:svc animated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // button1 for app-to-safari PCM
    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button1 addTarget:self
               action:@selector(openInSafari)
     forControlEvents:UIControlEventTouchUpInside];
    button1.frame = CGRectMake(80.0, 210.0, 160.0, 40.0);
    [button1 setBackgroundColor: UIColor.redColor];
    [button1 setTitle:@"to safari" forState: UIControlStateNormal];
    [self.view addSubview:button1];
    
    // cover button1 with UIEventAttributionView
    UIEventAttributionView *eventAttributionView1 = [[UIEventAttributionView alloc] init];
    [eventAttributionView1 setBackgroundColor: [UIColor.yellowColor colorWithAlphaComponent:0.5]];
    eventAttributionView1.translatesAutoresizingMaskIntoConstraints = NO;
    [button1 addSubview:eventAttributionView1];
    [NSLayoutConstraint activateConstraints: @[
        [button1.topAnchor constraintEqualToAnchor:eventAttributionView1.topAnchor],
        [button1.leadingAnchor constraintEqualToAnchor:eventAttributionView1.leadingAnchor],
        [button1.trailingAnchor constraintEqualToAnchor:eventAttributionView1.trailingAnchor],
        [button1.bottomAnchor constraintEqualToAnchor:eventAttributionView1.bottomAnchor]
    ]];
    
    // button2 (actually a UIView) for in-app PCM
    UITapGestureRecognizer *singleFingerTap =
      [[UITapGestureRecognizer alloc] initWithTarget:self
                                              action:@selector(openInSVC)];
    UIView *button2 = [[UIView alloc] initWithFrame:CGRectMake(80.0, 400.0, 160.0, 40.0)];
    [button2 addGestureRecognizer:singleFingerTap];
    [button2 setBackgroundColor: UIColor.redColor];
    [self.view addSubview:button2];
    
    // cover button2 with UIEventAttributionView
    UIEventAttributionView *eventAttributionView2 = [[UIEventAttributionView alloc] init];
    [eventAttributionView2 setBackgroundColor: [UIColor.yellowColor colorWithAlphaComponent:0.5]];
    eventAttributionView2.translatesAutoresizingMaskIntoConstraints = NO;
    [button2 addSubview:eventAttributionView2];
    [NSLayoutConstraint activateConstraints: @[
        [button2.topAnchor constraintEqualToAnchor:eventAttributionView2.topAnchor],
        [button2.leadingAnchor constraintEqualToAnchor:eventAttributionView2.leadingAnchor],
        [button2.trailingAnchor constraintEqualToAnchor:eventAttributionView2.trailingAnchor],
        [button2.bottomAnchor constraintEqualToAnchor:eventAttributionView2.bottomAnchor]
    ]];
}

- (void)safariViewControllerDidFinish:(SFSafariViewController *)controller {
    // debug
    [self dismissViewControllerAnimated:true completion:nil];
}


@end
