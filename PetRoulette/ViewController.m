//
//  ViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 23/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//
#import "PSYouTubeExtractor.h"
#import "PSYouTubeView.h"
#import "PetParser.h"
#import "ViewController.h"

@interface ViewController ()

@property (strong,nonatomic) PSYouTubeView *youtubeView;

@end

@implementation ViewController

- (IBAction)nextAction:(id)sender {
}

/*
 Method called when the view has been loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Labels get their contents
    [self.nameLabel setHidden:true];
    [self.descriptionLabel setHidden:true];
    [self.speciesLabel setHidden:true];
    [self.shelterLabel setHidden:true];
    
    //Initialization of good view size
    CGFloat size = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 250 : 500;
    CGRect videoRect = CGRectMake(0, 0, size, size);
    
    //Initialization of PSYouTubeView that will permits us to load and play the video
    PSYouTubeView *psYouTubeView = [[PSYouTubeView alloc] initWithFrame:videoRect showNativeFirst:YES];
    self.youtubeView = psYouTubeView;
    
    //load the main view contents
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
    
    int indice=-2;
    
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
            //we concatenate with 'watch?v='
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
 Methods that load the main view contents
 Fill all the label contents with the pet details from the model
 Load and play the main video
 */
-(void)updateVideoView{
    //Initialisation of PetParser wich will do the random API call
    PetParser *petParser = [[PetParser alloc] init];
    [petParser random];
    
    //Labels get their contents
    self.nextLabel.text = [NSString stringWithFormat:@"Nexted %lu time", (unsigned long)petParser.current_pet.pet_nextCount];
    self.nameLabel.text = petParser.current_pet.pet_name;
    [self.nameLabel setHidden:false];
    self.descriptionLabel.text = petParser.current_pet.pet_description;
    [self.descriptionLabel setHidden:false];
    self.speciesLabel.text = petParser.current_pet.pet_species_name;
    [self.speciesLabel setHidden:false];
    self.shelterLabel.text = petParser.current_pet.shelter_name;
    [self.shelterLabel setHidden:false];
    
    //Allow us to avoid size problems
    self.youtubeView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    
    //Test
    [self.videoView addSubview:self.youtubeView];
    
    /*Really short video -> for test
     NSURL *youTubeURL = [NSURL URLWithString:@"http://www.youtube.com/watch?v=wXw6znXPfy4"];
     */
    
    //transform the url of the current pet if it is needed to the good way
    NSString *url_final = [self convertYouTubeURLToGoodFormat:petParser.current_pet.pet_currentVideo.video_url];
    NSURL *youTubeURL = [NSURL URLWithString:url_final];

    //We load and play the video associated to the former youtube url
    [self.youtubeView loadAndPlayVideoWithUrl:youTubeURL];
    
    //ViewController become the observer of the video playing
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayBackDidFinish:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
}

/*
 Describe the behavior to adopt when the video finished to play
 @param notification is the way of notify the controller
 */
-(void)moviePlayBackDidFinish:(NSNotification*)notification{
    
    //we get the MPMoviePlayerController that send the notification (easy here, we have only one)
    MPMoviePlayerController *player = [notification object];
    
    //We retire the controller from observing it (it's done)
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:player];
    
    if ([player respondsToSelector:@selector(setFullscreen:animated:)]) {
        //We reloaded the main view to get a new random API Call and have an other video
        [self updateVideoView];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
