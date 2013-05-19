//
//  VideosTableViewController.m
//  PetRoulette
//
//  Created by IGPROJ-MAC01 on 05/05/13.
//  Copyright (c) 2013 IGPROJ-MAC01. All rights reserved.
//

#import "TestViewController.h"
#import "SingleVideoViewController.h"
#import "CustomCell.h"
#import "Video.h"
#import "LBYouTubePlayerController.h"
#import "ViewController.h"
#import "VideosTableViewController.h"

@interface VideosTableViewController ()


//URL pour voir la premiere image d'une video
//http://img.youtube.com/vi/FMVVDm1mwvM/0.jpg

@property (strong, nonatomic) NSArray *video_list;

@end

@implementation VideosTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.current_pet){
        self.video_list = self.current_pet.pet_videoList;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

/*
 Return the number of section in the table view given in parameters
 Put one section in table view
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

/*
 Return the number of rows needed
 There is as much rows as videos in the pet video list.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Return the number of rows in the section.
    if(self.current_pet){
        return self.current_pet.pet_videoList.count;
    }
    else return 0;
}

/*
 Return the heigh of the row selected at the index given as parameter
 Here we want it to be 100
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

/*
 We can have some url such as http://www.youtube.com/embed/p8mzlHiFDA0 or such as http://www.youtube.com/watch?v=p8mzlHiFDA0
 Allows us have the image of the video
 URL pour voir la premiere image d'une video
 http://img.youtube.com/vi/FMVVDm1mwvM/0.jpg
 @param urlTarget is the URL String we want to transform
 @return a String with watch instead of embed
 */
-(NSString*)convertYouTubeURLToImageYouTubeURL:(NSString*)urlTarget{
    
    NSArray *youtube_url_Array = [urlTarget componentsSeparatedByString:@"/"];
    
        
    //Initialization of a NSMutableString
    NSMutableString *url_final = [[NSMutableString alloc] init];
    
    //We get the last element of the array wich contains the identifier of the video
    url_final = [youtube_url_Array lastObject];
    
    //If the url string contains 'watch?v='
    if ([url_final hasPrefix:@"watch?v="]){
            NSArray *identifier = [url_final componentsSeparatedByString:@"="];
            url_final = [identifier lastObject];
    }
    //We concatenate withthe missing part of the url
    url_final = [NSString stringWithFormat:@"http://img.youtube.com/vi/%@/0.jpg", url_final];
    return url_final;
}

/*
 We can have some url such as http://www.youtube.com/embed/p8mzlHiFDA0 or such as http://www.youtube.com/watch?v=p8mzlHiFDA0
 Allows us to change any url to the second format, with '/watch?v=' instead of 'embed'
 @param urlTarget is the URL String we want to transform
 @return a String with watch instead of embed
 */
-(NSString*)convertYouTubeURLToGoodFormat:(NSString*)urlTarget{
    NSArray *youtube_url_Array = [urlTarget componentsSeparatedByString:@"/"];
    
    int indice=-2; //To be sure it can not be to 0
    
    //Initialization of a NSMutableString
    NSMutableString *url_final = [[NSMutableString alloc] init];
    
    //We get the first element of the array
    url_final = youtube_url_Array[0];
    
    //For each element
    for (int i = 1 ; i < youtube_url_Array.count ; i++){
        
        //We get the content of the element
        NSString *part = [youtube_url_Array objectAtIndex:i];
        
        //If the url string contains 'embed' instead of 'watch?v='
        if ([part isEqualToString:@"embed"]){
            //we keep the indice
            indice = [youtube_url_Array indexOfObject:part];
            //we concatenate with 'watch?v=' instead of '/embed/' element
            url_final = [NSString stringWithFormat:@"%@/watch?v=", url_final];
        }
        else{
            //if we are after the embed part, the identifier of the you tube video
            if([youtube_url_Array indexOfObject:part] == indice+1) {
                //we concatenate the identifier to 'watch?v='
                url_final = [NSString stringWithFormat:@"%@%@", url_final, part];
            }
            else{
                //else we concatenate as it was before
                url_final = [NSString stringWithFormat:@"%@/%@", url_final, part];
            }
        }
    }
    return url_final;
}

/*
 Method called when a cell is selected
 Behavior wanted when a cell is selected
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomCell *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil){        
        cell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //We get the first image of the youtube video
    NSString *url_final = [self convertYouTubeURLToImageYouTubeURL:[[self.video_list objectAtIndex:indexPath.row] video_url]];
    NSURL *youTubeURL = [NSURL URLWithString:url_final];
    NSData *imageData = [[NSData alloc] initWithContentsOfURL:youTubeURL];
    cell.myImageView.image = [UIImage imageWithData:imageData];
    
    //Put the title on primary text and the pet name on second label
    cell.primaryLabel.text = [[self.video_list objectAtIndex:indexPath.row] title];
    cell.secondaryLabel.text = self.current_pet.pet_name;

    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

/*
 Method called when an action on one of the button is made
 @param segue corespond to the link between the button and the target view
 @param id correspond to the sender button
 */
- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"MainMenu"]){
        
        //We get the target view controller
        ViewController *menuViewController = [segue destinationViewController];
        
        //we get the index corresponding to sender
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
        if (self.current_pet){ //we send the url of the video we want to play, the current pet, and the player
            
            //transform the url of the current pet if it is needed to the good way
            NSString *url_final = [self convertYouTubeURLToGoodFormat:[[self.video_list objectAtIndex:indexPath.row] video_url]];
            //NSLog(@"L'URL FINAL EST LE SUIVANT : %@", url_final);
            NSURL *youTubeURL = [NSURL URLWithString:url_final];
            
            menuViewController.controller = self.player;
            menuViewController.currentPet = self.current_pet;
            menuViewController.url_play = youTubeURL;
            menuViewController.state = 2; //to indicate it is for other video
        }
    }
}

@end
