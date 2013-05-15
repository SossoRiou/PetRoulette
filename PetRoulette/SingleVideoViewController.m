//
//  SingleVideoViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 09/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "LBYouTubePlayerController.h"
#import "SingleVideoViewController.h"

@interface SingleVideoViewController ()

@property (strong, nonatomic) LBYouTubePlayerController *player;

@end

@implementation SingleVideoViewController


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
    
     if (self.url_video){
         //Initialization of LBYouTubePlayerController that will permits us to load and play the video
         self.player = [[LBYouTubePlayerController alloc] initWithYouTubeURL:self.url_video quality:LBYouTubeVideoQualityLarge];
    
         //CGFloat size = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 250 : 500;
         //CGRect videoRect = CGRectMake(0, 0, size, size);
         //self.player.view.frame = videoRect;
         self.player.view.frame = CGRectMake(0.0f, 0.0f, 200.0f, 200.0f);

         self.player.view.center = self.view_video.center;
         self.player.delegate = self;
    
         //Link the UIView the the LBYouTubePlayerController's
         [self.view_video addSubview:self.player.view];
            
    }
    else{
        // Pop-up
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"PROBLEM"
                              message: @"There is no URL to watch video"
                              delegate: nil
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK",nil];
        [alert show];
    }
}

/*
 Describe the behavior to adopt when the video finished to play
 Depends to the reason why the video has stopped : if
 @param notification is the way of notify the controller
 
-(void)moviePlayBackDidFinish:(NSNotification*)notification{
    
    NSLog(@"THE SINGLE MOVIE HAS FINISHED ");
    
    //we get the MPMoviePlayerController that send the notification (easy here, we have only one)
    MPMoviePlayerController *player = [notification object];
    
    
    //We retire the controller from observing it (it's done)
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    
    
    if ([player respondsToSelector:@selector(setFullscreen:animated:)]) {
        [self.video_view removeFromSuperview];
    }
}
*/

/*
 Method allowing us to have the dimensions of the main screen and return the rect with that dimensions
 */
-(CGRect)sizeDynamically{
    //CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //CGFloat height = [UIScreen mainScreen].bounds.size.height;
    //CGRect final =  CGRectMake(10, 10, height-20, width-20);
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    return screenBounds;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
