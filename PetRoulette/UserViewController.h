//
//  UserViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "Appointment.h"
#import <UIKit/UIKit.h>

@interface UserViewController : UIViewController

//TextFields
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

//Appointment the user want to create
@property (strong, nonatomic) Appointment * current_appointment;

/*
 True if the string contains a '@'
 */
- (BOOL) isAnEmail:(NSString*)string;

/*
 Allow us to get the user name and e mail, in order to make an appointment
 @param textField is the textField where some string has been recorded, when the 'return' button has been pushed
 @return true
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField ;

/*
 Corresponds to the Save button
 If the current appointment is ready to be save, it make the API call
 */
- (IBAction)SaveAction:(id)sender;


@end
