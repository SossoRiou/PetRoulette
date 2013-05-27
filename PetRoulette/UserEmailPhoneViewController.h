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
 Controller of the last step in order to make an appointment : contains the field to keep user name, phone and email and the save button
*/
@interface UserEmailPhoneViewController : UIViewController

/* ------ Parameters of class --------*/

@property (strong, nonatomic) Appointment *current_app;

//Fields
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;

//design
@property (weak, nonatomic) IBOutlet UIImageView *logoAppView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

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

/*
 Method called when user begin editing in a field
 Allow us to move up the view and see what we write when the keyboard is up
 @param textField is the field concerned
 */
-(IBAction)textFieldBeginEdit:(UITextField*)textField;



@end
