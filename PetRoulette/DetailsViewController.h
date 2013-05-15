//
//  DetailsViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 30/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "Pet.h"
#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController


@property (strong, nonatomic) Pet *current_pet;

//Labels
@property (weak, nonatomic) IBOutlet UILabel *petNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *speciesNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *raceLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *availableUntilLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberVideosLabel;
- (IBAction)adoptAction:(id)sender;
- (IBAction)othersVideosAction:(id)sender;

@end


/*

 // Pop-up mechanism
 UIAlertView *alert = [[UIAlertView alloc]
 initWithTitle: @"VICTOIRE A TOI!!!!"
 message: [self.game playerAndScoreOfGame]
 delegate: nil
 cancelButtonTitle:@"I'm the best"
 otherButtonTitles:nil];
 [alert show];
 }


*/