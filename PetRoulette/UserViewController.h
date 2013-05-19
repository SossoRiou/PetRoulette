//
//  UserViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "Appointment.h"
#import <UIKit/UIKit.h>

/*
 Controller of the user name view
 Third step in order to make an appointment
 */
@interface UserViewController : UIViewController

/* ------ Parameters of class --------*/

//TextFields
@property (weak, nonatomic) IBOutlet UITextField *nameField;

//Appointment the user want to create
@property (strong, nonatomic) Appointment * current_appointment;


@end
