//
//  TestScrollViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 18/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "GenericParser.h"
#import "TestScrollViewController.h"

@interface TestScrollViewController ()

@end

@implementation TestScrollViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [self.scrollView setScrollEnabled:YES];
    [self.scrollView setContentSize:CGSizeMake(320,1000)];
    [super viewDidLoad];
    //[self.textview addSubview:self.scrollView];
	// Do any additional setup after loading the view.
}
/*
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];    
    if (textField == self.nameField) { //we get the name        
        if (textField.text){
            self.current_app.user_name = self.nameField.text;
        }
    }
    if (textField == self.emailField) {//we get the email
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
    if (textField == self.phoneField){//we get the phone number

        
    }
    return YES;
}*/

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
