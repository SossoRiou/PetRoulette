//
//  DonateViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 03/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "Pet.h"
#import <UIKit/UIKit.h>

@interface DonateViewController : UIViewController

@property (strong, nonatomic) Pet *current_pet;

@property (weak, nonatomic) IBOutlet UIImageView *donateLogoView;

@end
