//
//  ViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 23/04/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//
#import "PSYouTubeExtractor.h"
#import "PSYouTubeView.h"
#import "PetParser.h"
#import "ViewController.h"

@interface ViewController ()

@property (nonatomic) NSUInteger nextCount;

@end

@implementation ViewController

- (IBAction)nextAction:(id)sender {
}
/*
- (IBAction)PlayMovieAction:(id)sender{
    //Initialisation of everything
    PetParser *petParser = [[PetParser alloc] init];
    [petParser random];
    NSString *string_test = [[NSString alloc] init];
    string_test = @"http://www.youtube.com/watch?v=StJLvbPIvTw";
    
    // I get the path like this so the user can enter extension in the filename
    // NSString *path = [NSString stringWithFormat:@"%@/%@",
    //                  [[NSBundle mainBundle] resourcePath], string_test];
    // NSLog(@"Path of video file: %@", path);
    
    //NSURL *url = [NSURL fileURLWithPath:path];
    NSURL *url = [NSURL URLWithString:string_test];
    
    MPMoviePlayerViewController *vc = [[MPMoviePlayerViewController alloc] initWithContentURL:url];
    [vc.moviePlayer prepareToPlay];
    
    vc.moviePlayer.view.frame = self.videoView.bounds;
    [self.videoView addSubview:vc.moviePlayer.view];
    [vc.moviePlayer setContentURL:url];
    vc.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
}*/
- (void) movieFinishedCallback:(NSNotification*) aNotification {
    MPMoviePlayerController *player = [aNotification object];
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:MPMoviePlayerPlaybackDidFinishNotification
     object:player];
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    [self.nameLabel setHidden:true];
    [self.descriptionLabel setHidden:true];
    [self.speciesLabel setHidden:true];
    [self.shelterLabel setHidden:true];
    
    //Initialisation of everything
    PetParser *petParser = [[PetParser alloc] init];
    [petParser random];
    self.nextCount = petParser.current_pet.pet_nextCount;
    self.nextLabel.text = [NSString stringWithFormat:@"Nexted %lu time", (unsigned long)self.nextCount];
    
    //http://www.youtube.com/embed/p8mzlHiFDA0
    
    
    NSArray *youtube_url_Array = [petParser.current_pet.pet_currentVideo.video_url componentsSeparatedByString:@"/"];
    int indice=-2;
    //Initialisation d'un NSMutableString
    NSMutableString *url_final = [[NSMutableString alloc] init];
    
    //On y stocke le premier element du tableau donne (et donc le premier couple)
    url_final = youtube_url_Array[0];
    
    //Pour chaque element du tableau
    for (int i = 1 ; i < youtube_url_Array.count ; i++){
        //On recupere le contenu de l'element qui est de type String
        NSString *part = [youtube_url_Array objectAtIndex:i];
        
        if ([part isEqualToString:@"embed"]){
            indice = [youtube_url_Array indexOfObject:part];
            url_final = [NSString stringWithFormat:@"%@/watch?v=", url_final];
        }
        else{
            if([youtube_url_Array indexOfObject:part] == indice+1) {
                url_final = [NSString stringWithFormat:@"%@%@", url_final, part];
            }
            else{
                url_final = [NSString stringWithFormat:@"%@/%@", url_final, part];
            }
        }
        self.nameLabel.text = petParser.current_pet.pet_name;
        [self.nameLabel setHidden:false];
        self.descriptionLabel.text = petParser.current_pet.pet_description;
        [self.descriptionLabel setHidden:false];
        self.speciesLabel.text = petParser.current_pet.pet_species_name;
        [self.speciesLabel setHidden:false];
        self.shelterLabel.text = petParser.current_pet.shelter_name;
        [self.shelterLabel setHidden:false];
        
    }
    NSLog(@"URL FINAL : %@", url_final);
    
    
    NSURL *youTubeURL = [NSURL URLWithString:url_final];
    
    //NSURL *youTubeURL = [NSURL URLWithString:@"http://www.youtube.com/watch?v=75ZY15CAYEs"];
    CGFloat size = ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) ? 250 : 500;
    CGRect videoRect = CGRectMake(0, 0, size, size);
    
    PSYouTubeView *youTubeView = [[PSYouTubeView alloc] initWithYouTubeURL:youTubeURL frame:videoRect showNativeFirst:YES];
    youTubeView.center = self.videoView.center;
    youTubeView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    [self.videoView addSubview:youTubeView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
