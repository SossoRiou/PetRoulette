//
//  AdoptViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "ViewController.h"
//#import "PSYouTubeView.h"
#import "Appointment.h"
#import "Pet.h"
#import <UIKit/UIKit.h>

/*
 Controller of first step in order to make appointment
 Contains the shelter details
 */
@interface AdoptViewController : UIViewController

/* ------ Parameters of class --------*/

@property (strong, nonatomic) Pet *current_pet;

//Labels
@property (weak, nonatomic) IBOutlet UILabel *shelterNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *shelterAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *shelterPhoneNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *presentationLabel;

@end
