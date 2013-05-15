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
    [self.requestedDateLabel setHidden:true];
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

//automatic method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 Corresponds to the send button
 The date is added (after being sure it's a valid one) to the appointment and the user can go to the next step
 @param id is the identifier of the send button
 
- (IBAction)sendAction:(id)sender {
    //We get the chosen date
    self.date = [self.datePicker date];
    
    //We must check if the date is not before the today date
    NSDate *today = [NSDate date];
    if ([self.date compare:today] == NSOrderedAscending){
        //If it is : pop-up
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Sorry but we have a problem"
                              message: @"The date is before today."
                              delegate: nil
                              cancelButtonTitle:@"Back"
                              otherButtonTitles:nil];
        [alert show];
    }
    //self.requestedDateLabel.text = [NSString stringWithFormat:@"Requested Date : %@", self.date];
    self.current_appointment.requested_date = [NSString stringWithFormat:@"%@", self.date];
    NSLog(@"YOU'VE CHOSE THE DATE : %@", self.current_appointment.requested_date);
}*/

/*
 Method called when Send button is pushed
 @param segue corespond to the link between the button and the target view
 @param id correspond to the sender button
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //We identify what kind of link is concerned
    if ([segue.identifier isEqualToString:@"SendPush"]){
        //We get the target view controller
        UserViewController *userViewController = [segue destinationViewController];
    
        //We send the details we want : here we give it the current pet
       if (self.current_appointment){
            userViewController.current_appointment = self.current_appointment;
        }
        
        //We get the chosen date
        self.date = [self.datePicker date];
        
        //We must check if the date is not before the today date
        NSDate *today = [NSDate date];
        if ([self.date compare:today] == NSOrderedAscending){
            //If it is : pop-up
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle: @"Sorry but we have a problem"
                                  message: @"The date is before today."
                                  delegate: nil
                                  cancelButtonTitle:@"Back"
                                  otherButtonTitles:nil];
            [alert show];
        }
        //self.requestedDateLabel.text = [NSString stringWithFormat:@"Requested Date : %@", self.date];
        self.current_appointment.requested_date = [NSString stringWithFormat:@"%@", self.date];
        NSLog(@"YOU'VE CHOSE THE DATE : %@", self.current_appointment.requested_date);
    }
}

@end
