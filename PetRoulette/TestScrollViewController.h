//
//  TestScrollViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 18/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "Appointment.h"
#import <UIKit/UIKit.h>

@interface TestScrollViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//@property (weak, nonatomic) IBOutlet UITextField *nameField;
//@property (weak, nonatomic) IBOutlet UITextField *emailField;
//@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (strong, nonatomic) Appointment *current_app;


/*
 To be sure that email given is in a good format
 Say True if it's good, false else
 */
- (BOOL)validateEmailWithString:(NSString*)email;
/*
 Allows us to create the Generic Parser and to connect the API
 */
-(NSString*)connectAndSave_Appointment;

@end
