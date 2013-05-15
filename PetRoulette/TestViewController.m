//
//  TestViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 14/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "LBYouTubePlayerController.h"
#import "TestViewController.h"

@interface TestViewController ()

@property (strong, nonatomic) LBYouTubePlayerController *player;

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

- (void)viewDidLoad
{
    /*Really short video -> for test*/
     NSURL *youTubeURL = [NSURL URLWithString:@"http://www.youtube.com/watch?v=wXw6znXPfy4"];
     
    [super viewDidLoad];

    self.player = [[LBYouTubePlayerController alloc] initWithYouTubeURL:youTubeURL quality:LBYouTubeVideoQualityLarge];
    
    NSLog(@"URL VIDEO TRANSMIS : %@", self.url_video.description);
    
    //self.player = [[LBYouTubePlayerController alloc] initWithYouTubeURL:self.url_video quality:LBYouTubeVideoQualityLarge];

   // player.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin);
    
    self.player.view.frame = CGRectMake(0.0f, 0.0f, 200.0f, 200.0f);
    self.player.view.center = self.view.center;
    self.player.delegate = self;
    
    [self.view addSubview:self.player.view];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
