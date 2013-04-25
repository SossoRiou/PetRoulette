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

@property (strong, nonatomic) MPMoviePlayerController *moviePlayer;




- (IBAction)nextAction:(id)sender;


@property (weak, nonatomic) IBOutlet UIView *videoView;

@end
