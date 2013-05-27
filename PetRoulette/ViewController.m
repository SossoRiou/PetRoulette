
//
//  ViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 23/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//


#import "LBYouTubePlayerController.h"

#import "PetParser.h"
#import "DetailsViewController.h"
#import "AdoptViewController.h"
#import "DonateViewController.h"
#import "ViewController.h"

@implementation ViewController

/*
 Corresponds to Next Action : call the API to get a new Pet and play a new video
 @param id is the button identifier
 */
- (IBAction)nextAction:(id)sender {
    
    self.state = 1;
    
    //Step one : the current video must stop
    [self.controller stop];
    
    //Step two : reselect an other pet
    //Initialisation of PetParser wich will do the next API call
    PetParser *petParser = [[PetParser alloc] init];
    
    //next API call
    self.currentPet = [petParser next];
    
    if (self.currentPet){
        
        //Labels get their contents
        self.nextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.currentPet.pet_nextCount];

        //Transform the url of the current pet if needed
        NSString *url_final = [self convertYouTubeURLToGoodFormat:petParser.current_pet.pet_currentVideo.video_url];
        NSURL *youTubeURL = [NSURL URLWithString:url_final];
        self.url_play = youTubeURL;
            
        //We load and play the video associated to the new pet selected
       [self.controller loadAndPlayVideoAtUrl:self.url_play andQuality:LBYouTubeVideoQualityLarge];
    }
    self.state = 0;
}

/*
 Method called when the view has been loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];

    
     //Seeting up the background picture and buttons design
     UIColor *background = [[UIColor alloc] initWithPatternImage:[UIImage imageNamed:@"screecccn.jpg"]];
     self.controller.view.backgroundColor = background;
     
    [self.logoAppView setContentMode:UIViewContentModeScaleAspectFit];
    self.logoAppView.image = [UIImage imageNamed:@"logo_transparent.png"];
    
    [self.countNextView setContentMode:UIViewContentModeScaleAspectFit];
    self.countNextView.image = [UIImage imageNamed:@"this_pet_has_been_nexted.PNG"];
    
    [self.timesView setContentMode:UIViewContentModeScaleAspectFit];
    self.timesView.image = [UIImage imageNamed:@"times.PNG"];
    
    [[self.nextButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [self.nextButton setBackgroundImage:[UIImage imageNamed:@"next_transparent.png"] forState:UIControlStateNormal];
    
    [[self.viewMoreButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
      [self.viewMoreButton setBackgroundImage:[UIImage imageNamed:@"view_more.png"] forState:UIControlStateNormal];
    
    [[self.donateButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
     [self.donateButton setBackgroundImage:[UIImage imageNamed:@"donate.png"] forState:UIControlStateNormal];
    
    
    [[self.adoptButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
     [self.adoptButton setBackgroundImage:[UIImage imageNamed:@"adopt_transparent.png"] forState:UIControlStateNormal];
    
  
    if (!self.controller) {
        
        //initialization of the player controller
        self.controller = [[LBYouTubePlayerController alloc] initWithQuality:LBYouTubeVideoQualityLarge];
        
        //Initialization of good view size
        CGFloat size = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 200 : 300;
        CGRect videoRect = CGRectMake(0, 0, size, size);
        
        self.controller.delegate = self.controller;
    
        
        self.controller.view.frame = videoRect;
         
        //link the view to the controller view
        [self.videoView addSubview:self.controller.view];
        
        //ViewController become the observer of the video playing
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    }

    if (self.state == 2){ //case of otherVideo
        [self.videoView addSubview:self.controller.view];
        [self updateOtherVideoView];
        self.state = 0;
    }
    else { //at the loading of the view
        self.state = 0;
        [self updateVideoView];
    }
}

/*
 Methods that load the main view contents with the other video url
 Fill all the label contents with the former pet details
 Load and play the video
 */
-(void)updateOtherVideoView{
    
    //load and play the video from the url wanted
    [self.controller loadAndPlayVideoAtUrl:self.url_play andQuality:LBYouTubeVideoQualityLarge];
    
    //Labels get their contents
    self.nextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.currentPet.pet_nextCount];
    
    self.state = 0;
}

/*
 Methods that load the main view contents ; make the Random call
 Fill all the label contents with the pet details from the model
 Load and play the main video
 */
-(void)updateVideoView{
    
    //Initialisation of PetParser wich will do the random API call
    PetParser *petParser = [[PetParser alloc] init];
    //Random API call
    self.currentPet = [petParser random];
    
    
    //Labels get their contents
    self.nextLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.currentPet.pet_nextCount];
        
    /*Really short video -> for test
     NSURL *youTubeURL = [NSURL URLWithString:@"http://www.youtube.com/watch?v=wXw6znXPfy4"];
    */
    
    //Transform the url of the current pet if it is needed to the good way
    NSString *url_final = [self convertYouTubeURLToGoodFormat:self.currentPet.pet_currentVideo.video_url];
    NSURL *youTubeURL = [NSURL URLWithString:url_final];
    self.url_play = youTubeURL;
   
    //load and play the video from the url of the main video
    [self.controller loadAndPlayVideoAtUrl:self.url_play andQuality:LBYouTubeVideoQualityLarge];
    
    self.state = 0;
}

/*
 Describe the behavior to adopt when the video finished to play
 Depends to the reason why the video has stopped : if 
 @param notification is the way of notify the controller
 */
-(void)moviePlayBackDidFinish:(NSNotification*)notification{
    
    //We get the MPMoviePlayerController that send the notification (easy here, we have only one)
    MPMoviePlayerController *player = [notification object];
    
    //Test in order to know the reason of the movie to finish
    int reason = [[[notification userInfo] valueForKey:MPMoviePlayerPlaybackDidFinishNotification] longLongValue];
    if (reason == MPMovieFinishReasonPlaybackEnded) {
        NSLog(@"THE PLAYBACK ENDED");
    }
    else if (reason == MPMovieFinishReasonUserExited){
        NSLog(@"THE USER EXITED");
    }
    else if (reason == MPMovieFinishReasonPlaybackError){
        NSLog(@"THERE IS AN ERROR");
    }
    
    //We retire the controller from observing it
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    
    
    if ([player respondsToSelector:@selector(setFullscreen:animated:)]) {
        
        //If the video has stopped because it's finished, we reloaded the main view to get a new random API Call and have an other video
        if (self.state == 0)
            [self updateVideoView];
        //else it's mean it's a next action so we do not do nothing
    }
}

/*
 Method called when an action on one of the button is made
 @param segue corespond to the link between the button and the target view
 @param id correspond to the sender button 
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //[self.youtubeView.moviePlayerController pause];
    [self.controller pause];
    
    //We identify what kind of link is concerned
    if ([segue.identifier isEqualToString:@"DetailsPush"]){
        
        //We get the target view controller
        DetailsViewController *detailsViewController = [segue destinationViewController];
        
        //We send the details we want : here we give it the current pet
        if (self.currentPet){
            detailsViewController.current_pet = self.currentPet;
            
            //Test
            //[self.videoView removeFromSuperview];
            detailsViewController.player = self.controller;
        }
        
    }
    else if([segue.identifier isEqualToString:@"AdoptPush"]){

        //We get the target view controller
        AdoptViewController *adoptViewController = [segue destinationViewController];
        
        //We send the details we want : here we give it the current pet
        if (self.currentPet){
            adoptViewController.current_pet = self.currentPet;
        }
    }
    else{ //DonatePush //NOT IMPLEMENTED YET
        
        DonateViewController *donateViewController = [segue destinationViewController];
        //We send the details we want : here we give it the current pet
        if (self.currentPet){
            donateViewController.current_pet = self.currentPet;
        }
    }
}

/*
 We can have some url such as http://www.youtube.com/embed/p8mzlHiFDA0 or such as http://www.youtube.com/watch?v=p8mzlHiFDA0
 Allows us to change any url to the second format, with '/watch?v=' instead of 'embed'
 @param urlTarget is the URL String we want to transform
 @return a String with watch instead of embed
 */
-(NSString*)convertYouTubeURLToGoodFormat:(NSString*)urlTarget{
    NSArray *youtube_url_Array = [urlTarget componentsSeparatedByString:@"/"];
    
    int indice=-2; //To be sure it can not be to 0
    
    //Initialization of a NSMutableString
    NSMutableString *url_final = [[NSMutableString alloc] init];
    
    //We get the first element of the array
    url_final = youtube_url_Array[0];
    
    //For each element
    for (int i = 1 ; i < youtube_url_Array.count ; i++){
        
        //We get the content of the element
        NSString *part = [youtube_url_Array objectAtIndex:i];
        
        //If the url string contains 'embed' instead of 'watch?v='
        if ([part isEqualToString:@"embed"]){
            //we keep the indice
            indice = [youtube_url_Array indexOfObject:part];
            //we concatenate with 'watch?v=' instead of '/embed/' element
            url_final = [NSString stringWithFormat:@"%@/watch?v=", url_final];
        }
        else{
            //if we are after the embed part, the identifier of the you tube video
            if([youtube_url_Array indexOfObject:part] == indice+1) {
                //we concatenate the identifier to 'watch?v='
                url_final = [NSString stringWithFormat:@"%@%@", url_final, part];
            }
            else{
                //else we concatenate as it was before
                url_final = [NSString stringWithFormat:@"%@/%@", url_final, part];
            }
        }
    }
    return url_final;
}


//Automatic method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
