
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

@interface ViewController ()

@property (strong, nonatomic) LBYouTubePlayerController *controller;

//Allows us to make the difference between the end of a video when the user has waited too much than a next action
@property (nonatomic) BOOL state; //0 means end of video, 1 means Next


@end

@implementation ViewController

/*
 Corresponds to Next Action : call the API to get a new Pet and play a new video
 @param id is the button identifier
 */
- (IBAction)nextAction:(id)sender {
    
    self.state = 1;
    
    //[self.youtubeView.moviePlayerController stop];
    [self.controller stop];
    
    //Initialisation of PetParser wich will do the random API call
    PetParser *petParser = [[PetParser alloc] init];
    
    //API call
    self.currentPet = [petParser next];
    
    if (self.currentPet){
        
        //Labels get their contents
        self.nextLabel.text = [NSString stringWithFormat:@"Nexted %lu time", (unsigned long)self.currentPet.pet_nextCount];
        self.nameLabel.text = self.currentPet.pet_name;
        [self.nameLabel setHidden:false];

        
        //transform the url of the current pet if needed
        NSString *url_final = [self convertYouTubeURLToGoodFormat:petParser.current_pet.pet_currentVideo.video_url];
        NSURL *youTubeURL = [NSURL URLWithString:url_final];
        
        
        if (self.controller){
            [self.controller.view removeFromSuperview];
            self.controller = nil;
        }
    
        //We load and play the video associated to youtube url
       //[self.youtubeView loadAndPlayVideoWithUrl:youTubeURL];
         
         
        LBYouTubePlayerController *cont = [[LBYouTubePlayerController alloc] initWithYouTubeURL:youTubeURL quality:LBYouTubeVideoQualityLarge];
        self.controller = cont;
        
        //Initialization of good view size
        CGFloat size = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 250 : 500;
        CGRect videoRect = CGRectMake(0, 0, size, size);
        self.controller.view.frame = videoRect;
        //self.controller.view.frame = self.videoView.bounds;
        //self.videoView.backgroundColor = [UIColor redColor];
        //self.controller.view.center = self.videoView.center;
        [self.videoView addSubview:self.controller.view];
        
        
        
        //ViewController become the observer of the video playing
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
         
    }
}

/*
 Method called when the view has been loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.state = 0;
    
    //Labels get their contents
    [self.nameLabel setHidden:true];
    
    //Initialization of good view size
    //CGFloat size = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 250 : 500;
    //CGRect videoRect = CGRectMake(0, 0, size, size);
    
    //load the main view contents : the pet informations and video
    [self updateVideoView];
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
    self.nextLabel.text = [NSString stringWithFormat:@"Nexted %lu time", (unsigned long)self.currentPet.pet_nextCount];
    self.nameLabel.text = self.currentPet.pet_name;
    [self.nameLabel setHidden:false];
        
    /*Really short video -> for test
     NSURL *youTubeURL = [NSURL URLWithString:@"http://www.youtube.com/watch?v=wXw6znXPfy4"];
    */
    
    //transform the url of the current pet if it is needed to the good way
    NSString *url_final = [self convertYouTubeURLToGoodFormat:self.currentPet.pet_currentVideo.video_url];
    NSURL *youTubeURL = [NSURL URLWithString:url_final];

    //We load and play the video associated to the former youtube url
    LBYouTubePlayerController *cont = [[LBYouTubePlayerController alloc] initWithYouTubeURL:youTubeURL quality:LBYouTubeVideoQualityLarge];
    //cont.delegate = self;
    
    self.controller = cont;

    
    //Initialization of good view size
    CGFloat size = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 250 : 500;
    CGRect videoRect = CGRectMake(0, 0, size, size);
    self.controller.view.frame = videoRect;
    //self.controller.view.frame = self.videoView.bounds;
    //self.controller.view.center = self.videoView.center;
    [self.videoView addSubview:self.controller.view];
    
    //ViewController become the observer of the video playing
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

/*
 Describe the behavior to adopt when the video finished to play
 Depends to the reason why the video has stopped : if 
 @param notification is the way of notify the controller
 */
-(void)moviePlayBackDidFinish:(NSNotification*)notification{
    
    NSLog(@"THE MOVIE HAS FINISHED ");
    //NSLog(@"THE CURRENT VIDEO IS %@", self.currentPet.pet_currentVideo);
    
    //we get the MPMoviePlayerController that send the notification (easy here, we have only one)
    MPMoviePlayerController *player = [notification object];
    
    //TEST
    /*
    if ([player playbackState]==0){
        NSLog(@"THE MOVIE IS PAUSED");
    }*/
    
    
        //We retire the controller from observing it (it's done)
        [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    

        if ([player respondsToSelector:@selector(setFullscreen:animated:)]) {
            
            //If the video has stopped because it's finished, we reloaded the main view to get a new random API Call and have an other video
            if (self.state != 1)
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
 Method allowing us to have the dimensions of the main screen and return the rect with that dimensions
 */
-(CGRect)resizeDynamically{
    
    
    //CGFloat width = [UIScreen mainScreen].bounds.size.width;
    //CGFloat height = [UIScreen mainScreen].bounds.size.height;
    //CGRect final =  CGRectMake(10, 10, height-20, width-20);
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    return screenBounds;
}


//Automatic method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
