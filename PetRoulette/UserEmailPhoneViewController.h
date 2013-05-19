//
//  UserEmailPhoneViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 17/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "Appointment.h"
#import <UIKit/UIKit.h>

/*
 Controller of the last step in order to make an appointment : contains the field to keep user phone and email and the send button
*/
@interface UserEmailPhoneViewController : UIViewController

/* ------ Parameters of class --------*/

@property (strong, nonatomic) Appointment *current_app;

//Fields
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

/* ------ Methods of class --------*/

/*
 To be sure that email given is in a good format
 Say True if it's good, false else
 */
- (BOOL)validateEmailWithString:(NSString*)email;

/*
 Corresponds to the Save button
 If the current appointment is ready to be save, it make the API call
 */
- (IBAction)saveAction:(id)sender;

/*
 Allow us to get the user name and e mail, in order to make an appointment
 @param textField is the textField where some string has been recorded, when the 'return' button has been pushed
 @return true
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField ;

/*
 Allows us to create the Generic Parser and to connect the API
 */
-(NSString*)connectAndSave_Appointment;


@end
