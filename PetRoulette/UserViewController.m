//
//  UserViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "GenericParser.h"
#import "UserEmailPhoneViewController.h"
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
                              delegate: self
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
           return YES;
}

/*
 Method called when Ok button is pushed
 The name is added to the appointment and the user can go to the next step
 @param id correspond to the sender button
 @param segue corespond to the link between the button and the target view
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //We identify what kind of link is concerned
    if ([segue.identifier isEqualToString:@"OKPush"]){
        //We get the target view controller
      UserEmailPhoneViewController  *userEmailPhoneViewController = [segue destinationViewController];
        
        //We send the details we want : here we give it the current pet
        if (self.current_appointment){
            userEmailPhoneViewController.current_app = self.current_appointment;
        }
    }
}
@end
