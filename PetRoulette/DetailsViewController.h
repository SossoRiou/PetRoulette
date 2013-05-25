//
//  DetailsViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 30/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "LBYouTubePlayerController.h"
#import "Pet.h"
#import <UIKit/UIKit.h>

/*
 Controller of details view
 Composed by pet details
 */
@interface DetailsViewController : UIViewController

/* ------ Parameters of class --------*/

@property (strong, nonatomic) Pet *current_pet;
@property (strong, nonatomic) LBYouTubePlayerController *player;


//Labels
@property (weak, nonatomic) IBOutlet UIImageView *viewMoreLogoView;
@property (weak, nonatomic) IBOutlet UILabel *petNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *speciesNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *raceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *availableUntilLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberVideosLabel;
@property (weak, nonatomic) IBOutlet UIButton *adoptButton;

@property (weak, nonatomic) IBOutlet UIButton *othersVideosButton;

/* ------ Methods of class --------*/

- (IBAction)adoptAction:(id)sender;
- (IBAction)othersVideosAction:(id)sender;

@end
