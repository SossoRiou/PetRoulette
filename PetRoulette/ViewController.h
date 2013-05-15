//
//  ViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 23/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>

@interface ViewController : UIViewController

/* ------ Parameters of class --------*/

//Labels
@property (weak, nonatomic) IBOutlet UILabel *nextLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


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
 Method allowing us to have the dimensions of the main screen and return the rect with that dimensions
 */
-(CGRect)resizeDynamically;

//View
@property (weak, nonatomic) IBOutlet UIView *videoView;

//Actual Pet tthat the video describe and that the details talk about
@property (strong, nonatomic) Pet *currentPet;

@end
