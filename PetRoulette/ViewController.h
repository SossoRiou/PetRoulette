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

@property (weak, nonatomic) IBOutlet UILabel *nextLabel;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *speciesLabel;

@property (weak, nonatomic) IBOutlet UILabel *shelterLabel;


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

@property (weak, nonatomic) IBOutlet UIView *videoView;


@end
