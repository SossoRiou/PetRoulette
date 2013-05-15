//
//  VideosTableViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 05/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "Pet.h"
#import <UIKit/UIKit.h>

@interface VideosTableViewController : UITableViewController

@property (strong, nonatomic) Pet *current_pet;


//@property (weak, nonatomic) IBOutlet UIView *video_view;
@property (weak, nonatomic) IBOutlet UIView *view_video;

@end
