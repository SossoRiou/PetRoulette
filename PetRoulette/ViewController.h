//
//  ViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 23/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//
#import "LBYouTubePlayerController.h"
#import "Pet.h"
#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

/*
 Main Controller
 Is composed by a video and next, adopt, donate button
 @author Solene Riou
 */
@interface ViewController : UIViewController

/* ------ Parameters of class --------*/

//Labels
@property (weak, nonatomic) IBOutlet UILabel *nextLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

//url of the video currently played when the view is loaded
@property (strong, nonatomic) NSURL *url_play;

//View
@property (weak, nonatomic) IBOutlet UIView *videoView;

//Actual Pet that the video describe 
@property (strong, nonatomic) Pet *currentPet;

//PlayerController that handle the video playing
@property (strong, nonatomic) LBYouTubePlayerController *controller;

//Allows us to make the difference between the end of a video when the user has waited too much than a next action
@property (nonatomic) BOOL state; //0 means end of video, 1 means Next, 2 means others Videos


/* ------ Methods of class --------*/

/*
 Corresponds to Next Action : call the API to get a new Pet and play a new video
 @param id is the button identifier
 */
- (IBAction)nextAction:(id)sender;

/*
 We can have some url such as http://www.youtube.com/embed/p8mzlHiFDA0 or such as http://www.youtube.com/watch?v=p8mzlHiFDA0
 Allows us to change any url to the second format, with '/watch?v=' instead of 'embed'
 @param urlTarget is the URL String we want to transform
 @return a String with watch instead of embed
 */
-(NSString*)convertYouTubeURLToGoodFormat:(NSString*)urlTarget;

/*
 Methods that load the main view contents
 Fill all the label contents with the pet details from the model
 Load and play the main video
 */
-(void)updateVideoView;


/*
 Methods that load the main view contents with the other video url
 Fill all the label contents with the former pet details
 Load and play the video
 */
-(void)updateOtherVideoView;

@end
