//
//  UserEmailPhoneViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 17/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "GenericParser.h"
#import "UserEmailPhoneViewController.h"

@interface UserEmailPhoneViewController ()

@end

@implementation UserEmailPhoneViewController

//Automatic method
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//method call when view did appear
-(void)viewDidAppear:(BOOL)animated{
    
    //Initialize scrollView size
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320, 460)];
}

/*
 Method called when user begin editing in a field
 Allow us to move up the view and see what we write when the keyboard is up
 @param textField is the field concerned
 */
-(IBAction)textFieldBeginEdit:(UITextField*)textField{
    
    //Srcoll view get bigger
    [self.scrollView setContentSize:CGSizeMake(320, 560)];
    
    //set up point
    CGRect textFieldSize = textField.bounds;
    textFieldSize = [textField convertRect:textFieldSize fromView:self.scrollView];
    CGPoint point = textFieldSize.origin;
    point.y = -point.y -40;
    point.x = 0;
    [self.scrollView setContentOffset:point animated:YES];
}



/*
 Method called when the view is loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
        
    //Set up design
    [self.logoAppView setContentMode:UIViewContentModeScaleAspectFit];
    self.logoAppView.image = [UIImage imageNamed:@"logo_transparent.png"];
    
    [[self.saveButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [self.saveButton setBackgroundImage:[UIImage imageNamed:@"save_yellow.PNG"] forState:UIControlStateNormal];
    
    
    if (!self.current_app){
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

/*
 Allow us to get the user name and e mail, in order to make an appointment
 @param textField is the textField where some string has been recorded, when the 'return' button has been pushed
 @return true
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.scrollView setContentSize:CGSizeMake(320, 460)];
    
    if (textField == self.nameField){
        
        //keyboard off
        [textField resignFirstResponder];
        if (textField.text){
            self.current_app.user_name = self.nameField.text;
        }
    }
    if (textField == self.emailField) { //we get the email
        
        //keyboard off
        [textField resignFirstResponder];
        
        if (textField.text){
            if ([self validateEmailWithString:textField.text]){ //The email is in a good format
                self.current_app.user_email = self.emailField.text; //we add it to the current appointment
            }
            else {
                // Pop-up
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"There is a problem"
                                      message:@"The email must be describe as the following example rocky@hotmail.com"
                                      delegate: self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:nil];
                [alert show];
            }
        }
    }
    if (textField == self.phoneNumberField) { //we get the phone number
        if (textField.text){
            self.current_app.user_phoneNumber = self.phoneNumberField.text;
            //keyboard off
            [textField resignFirstResponder];
        }
    }
    return YES;
}

//Automatic method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Corresponds to the Save button
 If the current appointment is ready to be save, it make the API call
 If something is missing, a pop-up appears to the user and the appointment is not saved
 */
- (IBAction)saveAction:(id)sender {
    if (self.current_app){
        
        if ([self.current_app saveAppointment]){ //we can post it
            
            //API call : post Appointment
            if([[self connectAndSave_Appointment] isEqualToString:@"False"]){//MUST CHANGE TO "True" !!!!!!!!!!!!!!!!!
                
                //The post has succeeded :
                // Pop-up
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"CONGRATULATIONS"
                                      message: [NSString stringWithFormat:@"The appointment has been recorded with sucess : %@ are expected on the %@ at %@ in order to adopt %@", self.current_app.user_name, self.current_app.requested_date, self.current_app.appointment_pet.shelter_address, self.current_app.appointment_pet.pet_name]
                                      delegate: nil
                                      cancelButtonTitle:@"OK"
                                      otherButtonTitles:nil];
                [alert show];
                
                //Do we exit? Otherwise we'll be able to post twice the same appointment
            }
            else if([[self connectAndSave_Appointment] isEqualToString:@"Fail"]){ //the call has failed because of missing details
               
                NSLog(@"The appointment has failed, something is missing!!");
                // Pop-up
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"SORRY"
                                      message: [NSString stringWithFormat:@"We should manage to save the appointment but we can't!! Something is missing !"]
                                      delegate: self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:nil];
                [alert show];
            }
            else if ([[self connectAndSave_Appointment] isEqualToString:@"False"]){ 
                
                //WHEN APPOINTMENT IS DONE WE MUST LET THIS FOLLOWING PART
                /*
                NSLog(@"The appointment has been refused");
                // Pop-up
                UIAlertView *alert = [[UIAlertView alloc]
                                      initWithTitle: @"SORRY"
                                      message: [NSString stringWithFormat:@"The appointment has been refused"]
                                      delegate: self
                                      cancelButtonTitle:@"Cancel"
                                      otherButtonTitles:nil];
                [alert show];
                */
            }
        }
        else{ // Missing details
            // Pop-up
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"SORRY"
                                  message: @"The appointment could not be recorded because of missing informations. You must do it again."
                                  delegate: self
                                  cancelButtonTitle:@"Cancel"
                                  otherButtonTitles:nil];
            [alert show];
        }
    }
}

/*
 To be sure that email given is in a good format
 Say True if it's good, false else
 */
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

/*
 Allows us to create the Generic Parser and to connect the API
 */
-(NSString*)connectAndSave_Appointment{
    NSString *succeed;
    if (self.current_app){
        // The above data is fine, as explored here.
        NSLog(@"formContactName = %@", self.current_app.user_name);
        NSLog(@"formEmail = %@", self.current_app.user_email);
        NSLog(@"formPhone = %@", self.current_app.user_phoneNumber);
        NSLog(@"formTime = %@", @"BLBLA");
        NSLog(@"date = %@", self.current_app.requested_date);
        
        GenericParser *parser = [[GenericParser alloc] init];
        succeed = [parser appointmentWithName:self.current_app.user_name withEmail:self.current_app.user_email withContactNumber:self.current_app.user_phoneNumber atTime:@"BLBLA" forRequestedDate:self.current_app.requested_date];
    }
    return succeed;
}

@end
