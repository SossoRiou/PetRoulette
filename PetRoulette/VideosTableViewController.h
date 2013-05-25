//
//  VideosTableViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 05/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "LBYouTubePlayerController.h"
#import "Pet.h"
#import <UIKit/UIKit.h>

/*
 Controller of the video list
 */
@interface VideosTableViewController : UITableViewController

/* ------ Parameters of class --------*/

@property (strong, nonatomic) Pet *current_pet;
@property (strong, nonatomic) LBYouTubePlayerController *player;

//view
@property (weak, nonatomic) IBOutlet UIView *view_video;

/* ------ Methods of class --------*/

/*
 We can have some url such as http://www.youtube.com/embed/p8mzlHiFDA0 or such as http://www.youtube.com/watch?v=p8mzlHiFDA0
 Allows us to change any url to the second format, with '/watch?v=' instead of 'embed'
 @param urlTarget is the URL String we want to transform
 @return a String with watch instead of embed
 */
-(NSString*)convertYouTubeURLToGoodFormat:(NSString*)urlTarget;

/*
 We can have some url such as http://www.youtube.com/embed/p8mzlHiFDA0 or such as http://www.youtube.com/watch?v=p8mzlHiFDA0
 Allows us have the image of the video
 URL pour voir la premiere image d'une video
 http://img.youtube.com/vi/FMVVDm1mwvM/0.jpg
 @param urlTarget is the URL String we want to transform
 @return a String with watch instead of embed
 */
-(NSString*)convertYouTubeURLToImageYouTubeURL:(NSString*)urlTarget;

@end
