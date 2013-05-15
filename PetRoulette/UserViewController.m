//
//  UserViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "UserViewController.h"

@interface UserViewController ()

@end

@implementation UserViewController

//Automatic method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 Method called when the view is loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!self.current_appointment){
        NSLog(@"There is a problem, there is no appointment initialized !");
        // Pop-up
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Sorry but we have a problem"
                              message: @"There is a problem, there is no appointment initialized !"
                              delegate: nil
                              cancelButtonTitle:@"Back"
                              otherButtonTitles:nil];
        [alert show];
    }
}

//Automatic method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/* 
 True if the string contains a '@'
*/ 
- (BOOL) isAnEmail:(NSString*)string{
    NSArray *email_part = [string componentsSeparatedByString:@"@"];
    if (email_part){
        if (email_part.count == 2){
            return true;
        }
    }
        return false;
}


/*
 Allow us to get the user name and e mail, in order to make an appointment
 @param textField is the textField where some string has been recorded, when the 'return' button has been pushed
 @return true
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    //Identification du textField concerne par l'appel
    if (textField == self.nameField) { //we get the name
        
        if (textField.text){ //we only take the name if there is one
            self.current_appointment.user_name = self.nameField.text;
            //keyboard off
            [textField resignFirstResponder];
        }
    }
    if (textField == self.emailField) { //we get the email
        if (textField.text){
            if ([self isAnEmail:textField.text]){ //The email is in a good format
                self.current_appointment.user_email = self.emailField.text;
            }
            else {
                // Pop-up
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"There is a problem"
                                      message:@"The email must be describe as the following example rocky@hotmail.com"
                                      delegate: nil
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:nil];
                [alert show];
            }
            //keyboard off
            [textField resignFirstResponder];
        }
    }
    if (textField == self.phoneNumberField) { //we get the phone number
        if (textField.text){
            self.current_appointment.user_phoneNumber = self.phoneNumberField.text;
            //keyboard off
            [textField resignFirstResponder];
        }
    }
    return YES;
}
/*
 Corresponds to the Save button
 If the current appointment is ready to be save, it make the API call
 If something is missing, a pop-up appears to the user and the appointment is not saved
 */
- (IBAction)SaveAction:(id)sender {
    if (self.current_appointment){
        
        if ([self.current_appointment saveAppointment]){
            //APPEL A L'API
            
            //SI REUSSI :
            // Pop-up
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"CONGRATULATIONS"
                                  message: [NSString stringWithFormat:@"The appointment has been recorded with sucess : %@ are expected on the %@ at %@ in order to adopt %@", self.current_appointment.user_name, self.current_appointment.requested_date, self.current_appointment.appointment_pet.shelter_address, self.current_appointment.appointment_pet.pet_name]
                                  delegate: nil
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil];
            [alert show];
            //SINON = l'APPEL A ECHOUE
            //NSLog(@"We should manage to save the appointment but we can't!!");
        }
        else{ // ELEMENTS MANQUANTS
            // Pop-up
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"SORRY"
                                  message: @"The appointment could not be recorded because of missing informations. You must do it again."
                                  delegate: nil
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:nil];
            [alert show];

            
        }
    }
}



@end
