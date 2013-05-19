//
//  DetailsViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 30/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "VideosTableViewController.h"
#import "AdoptViewController.h"
#import "DetailsViewController.h"

@implementation DetailsViewController

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
 Method called when the details view is loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.current_pet){
        
        //Labels get their contents
        self.petNameLabel.text = self.current_pet.pet_name;
        self.descriptionLabel.text = self.current_pet.pet_description;
        self.speciesNameLabel.text = self.current_pet.pet_species_name;
        self.dateOfBirthLabel.text = self.current_pet.pet_birthDate;
        self.raceLabel.text = self.current_pet.pet_race;
        self.availableUntilLabel.text = self.current_pet.pet_available_untilDate;
        self.numberVideosLabel.text = [NSString stringWithFormat:@"There are %lu others videos of %@", (unsigned long)self.current_pet.pet_videoList.count, self.current_pet.pet_name];
    }
    else {
        // Pop-up
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle: @"PROBLEM"
                              message: @"There is no pet we can display details"
                              delegate: nil
                              cancelButtonTitle:@"Cancel"
                              otherButtonTitles:@"OK",nil];
        [alert show];
    }    
}

/*
 Method called when an action on one of the button is made
 @param segue corespond to the link between the button and the target view
 @param id correspond to the sender button
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    //We identify what kind of link is concerned
    if ([segue.identifier isEqualToString:@"adoptPush"]){
        //We get the target view controller
        AdoptViewController *adoptViewController = [segue destinationViewController];
        
        //We send the details we want : here we give it the current pet
        if (self.current_pet){
            adoptViewController.current_pet = self.current_pet;
        }
    }
    else if([segue.identifier isEqualToString:@"othersVideosPush"]){
        //We get the target view controller
        VideosTableViewController *videoTableViewController = [segue destinationViewController];
                
        //We send the details we want : here we give it the current pet
        if (self.current_pet){
            videoTableViewController.current_pet = self.current_pet;
            
            //Test
            videoTableViewController.player = self.player;
        }
    }
}

//Automatic method
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)adoptAction:(id)sender {
    
}

- (IBAction)othersVideosAction:(id)sender {
}
@end
