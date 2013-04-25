//
//  TestViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 23/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "PSYouTubeExtractor.h"
#import "PSYouTubeView.h"
#import "PetParser.h"
#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void) movieFinishedCallback:(NSNotification*) aNotification {
    MPMoviePlayerController *player = [aNotification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
}
- (void)viewDidLoad
{
    
    NSURL *youTubeURL = [NSURL URLWithString:@"http://www.youtube.com/watch?v=Vo0Cazxj_yc"];
    CGFloat size = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 250 : 500;
    CGRect videoRect = CGRectMake(0, 0, size, size);
    
    PSYouTubeView *youTubeView = [[PSYouTubeView alloc] initWithYouTubeURL:youTubeURL frame:videoRect showNativeFirst:YES];
    youTubeView.center = self.videoView.center;
    youTubeView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.videoView addSubview:youTubeView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)testAction:(id)sender {
    self.testlabel.text = @"BLAAAAA";
}
@end
