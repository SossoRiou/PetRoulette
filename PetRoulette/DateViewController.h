//
//  DateViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "Appointment.h"
#import <UIKit/UIKit.h>

@interface DateViewController : UIViewController

//Allows the user to choose a date
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

//Label
@property (weak, nonatomic) IBOutlet UILabel *requestedDateLabel;

//Appointment where the date must be added
@property (strong, nonatomic) Appointment * current_appointment;

/*
 Corresponds to the send button
 The date is added (after being sure it's a valid one) to the appointment and the user can go to the next step
 @param id is the identifier of the send button
 */
//- (IBAction)sendAction:(id)sender;
@end

