//
//  AdoptViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//
#import "DateViewController.h"
#import "AdoptViewController.h"

@interface AdoptViewController ()

//The appointment instance where we want to add user information
@property (strong, nonatomic) Appointment *current_appointment;

@end

@implementation AdoptViewController

/*
 Getter of the current appointment and initializer
 */
-(Appointment *)current_appointment{
    if (!_current_appointment){
        if (self.current_pet){
            _current_appointment = [[Appointment alloc] initWithPet:self.current_pet];
        }
        else {
            _current_appointment = [[Appointment alloc] init];
        }
    }
    return _current_appointment;
}

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
 Method called when the adopt view is loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
        
    if (self.current_pet){ //the current pet must have been initialized with the former controller
        
        //Labels gets their contents
        self.shelterNameLabel.text = self.current_pet.shelter_name;
        self.shelterAddressLabel.text = self.current_pet.shelter_address;
        self.shelterPhoneNumberLabel.text = self.current_pet.shelter_phoneNumber;
        self.presentationLabel.text = [NSString stringWithFormat:@"You want %@? You can adopt it!", self.current_pet.pet_name];
    }
    else{
        NSLog(@"There is a problem, there is no pet to adopt here !");
        [self.shelterNameLabel setHidden:true];
        [self.shelterAddressLabel setHidden:true];
        [self.shelterPhoneNumberLabel setHidden:true];
        [self.presentationLabel setHidden:true];
        // Pop-up
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"Sorry but we have a problem"
                              message: @"There are no pet to adopt here"
                              delegate: nil
                              cancelButtonTitle:@"Back"
                              otherButtonTitles:nil];
        [alert show];
    }
}

/*
 Method called when Choose a date button is pushed
 @param segue corespond to the link between the button and the target view
 @param id correspond to the sender button
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //We identify what kind of link is concerned
    if ([segue.identifier isEqualToString:@"SelectDatePush"]){
        //We get the target view controller
        DateViewController *dateViewController = [segue destinationViewController];
        
        //We send the details we want : here we give the current appointment
        if (self.current_appointment){
            dateViewController.current_appointment = self.current_appointment;
        }
    }
}


//Automatic method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
