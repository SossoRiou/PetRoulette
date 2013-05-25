//
//  DonateViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "DonateViewController.h"

@interface DonateViewController ()

@end

@implementation DonateViewController

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
 Method called when the donate view is loaded
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set up design
    [self.donateLogoView setContentMode:UIViewContentModeScaleAspectFit];
    self.donateLogoView.image = [UIImage imageNamed:@"donate.png"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
