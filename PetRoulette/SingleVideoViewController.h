//
//  SingleVideoViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 09/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleVideoViewController : UIViewController

//@property (strong, nonatomic) IBOutlet UIView *video_view;
@property (strong, nonatomic) NSURL *url_video;
@property (weak, nonatomic) IBOutlet UIView *view_video;

/*
Method allowing us to have the dimensions of the main screen and return the rect with that dimensions
*/
-(CGRect)sizeDynamically;

@end
