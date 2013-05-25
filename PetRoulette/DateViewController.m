//
//  DateViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "UserViewController.h"
#import "DateViewController.h"

@interface DateViewController ()

//Requested date
@property (strong, nonatomic) NSDate *date;

@end



@implementation DateViewController

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
 Method called when the date view is loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set up design
    [self.adoptLogoView setContentMode:UIViewContentModeScaleAspectFit];
    self.adoptLogoView.image = [UIImage imageNamed:@"adopt_transparent.png"];
    

    [[self.okButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [self.okButton setBackgroundImage:[UIImage imageNamed:@"OK_blue.PNG"] forState:UIControlStateNormal];
    
    [[self.sendButton imageView] setContentMode:UIViewContentModeScaleAspectFit];
    [self.sendButton setBackgroundImage:[UIImage imageNamed:@"SEND_black.PNG"] forState:UIControlStateNormal];
    
    //We hide and enable the send button as long as a valid date is not selected
    [self.sendButton setHidden:TRUE]; 
    self.sendButton.enabled = NO;
    
    
    
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

//automatic method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Method called when Send button is pushed
 Corresponds to the send button
 The date is added (after being sure it's a valid one) to the appointment and the user can go to the next step
 @param id correspond to the sender button
 @param segue corespond to the link between the button and the target view
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //We identify what kind of link is concerned
    if ([segue.identifier isEqualToString:@"SendPush"]){
        //We get the target view controller
        UserEmailPhoneViewController *userViewController = [segue destinationViewController];
    
        //We send the details we want : here we give it the current pet
       if (self.current_appointment){
            userViewController.current_app = self.current_appointment;
        }
    }
}

/*
 Method called when ok button is selected
 Allow the user, if a name is provided, to go to the next step in order to make an appointment
 */
- (IBAction)okAction:(id)sender {
    
    //We read the selected date on the datepicker
    NSDate *selected_date = [self.datePicker date];
    
    if ([self isDateIsEarlierThanToday:selected_date]){
        //If it is : pop-up
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Sorry but we have a problem"
                              message: @"The date is before today."
                              delegate: self
                              cancelButtonTitle:@"Back"
                              otherButtonTitles:nil];
        [alert show];
    }
    else { //the date is good
        self.date = selected_date;
        self.current_appointment.requested_date = [NSString stringWithFormat:@"%@", self.date];
        NSLog(@"YOU'VE CHOSE THE DATE : %@", self.current_appointment.requested_date);
        
        //We put enable the send button
        self.sendButton.enabled = YES;
        [self.sendButton setHidden:NO];
    }
}

/*
 Help us to see if a date is earlier than today
 Say True if the date is earlier than today, else false.
 */
- (BOOL)isDateIsEarlierThanToday:(NSDate *)date
{
    NSDate* enddate = date;
    NSDate* today_date = [NSDate date];
    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:today_date];
    double secondsInMinute = 60;
    NSInteger secondsBetweenDates = distanceBetweenDates / secondsInMinute;
    
    if (secondsBetweenDates == 0)
        return true;
    else if (secondsBetweenDates < 0)
        return true;
    else
        return false;
}

@end
