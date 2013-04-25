//
//  TestViewController.h
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 23/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//
#import <MediaPlayer/MediaPlayer.h>
#import <UIKit/UIKit.h>

@interface TestViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *videoView;
@property (weak, nonatomic) IBOutlet UILabel *testlabel;

- (IBAction)testAction:(id)sender;

@end
