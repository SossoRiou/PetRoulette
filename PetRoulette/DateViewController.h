//
//  DateViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "Appointment.h"
#import <UIKit/UIKit.h>

/*
 Controller of the second step in order to make an appointment 
 Contin a date picker to select a requested date
 */
@interface DateViewController : UIViewController

/* ------ Parameters of class --------*/

//Allows the user to choose a date
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

//Label
@property (weak, nonatomic) IBOutlet UILabel *requestedDateLabel;

//Appointment where the date must be added
@property (strong, nonatomic) Appointment * current_appointment;

@property (weak, nonatomic) IBOutlet UIButton *sendButton;

/* ------ Methods of class --------*/

/*
 Method called when ok button is selected
 Allow the user, if a name is provided, to go to the next step in order to make an appointment
 */
- (IBAction)okAction:(id)sender;

/*
 Help us to see if a date is earlier than today
 Say True if the date is earlier than today, else false.
 */
- (BOOL)isDateIsEarlierThanToday:(NSDate *)date;


@end

